import 'dart:math' as math;

import '../constants/app_constants.dart';
import 'geodesy.dart';
import 'matrix.dart';

class DevicePrior {
  const DevicePrior({
    required this.deviceId,
    required this.prior,
    this.sigma = 3.0,
    this.isFixed = false,
  });

  final String deviceId;
  final EnuPoint prior;
  final double sigma;
  final bool isFixed;
}

class PairwiseRange {
  const PairwiseRange({
    required this.deviceAId,
    required this.deviceBId,
    required this.distance,
    this.sigma = 1.0,
  });

  final String deviceAId;
  final String deviceBId;
  final double distance;
  final double sigma;
}

class NetworkAdjustmentResult {
  const NetworkAdjustmentResult({
    required this.devicePositions,
    required this.rmsResidual,
    required this.converged,
    required this.iterations,
    required this.quality,
    this.standardDeviations = const {},
  });

  final Map<String, EnuPoint> devicePositions;
  final double rmsResidual;
  final bool converged;
  final int iterations;
  final String quality; // 'good', 'fair', 'poor'
  final Map<String, double> standardDeviations;
}

/// Joint Weighted Least-Squares (WLS) Network Adjustment Solver for multi-device GNSS + BLE networks.
class NetworkAdjustmentSolver {
  NetworkAdjustmentResult solve({
    required List<DevicePrior> devices,
    required List<PairwiseRange> ranges,
    double huberK = 1.5,
    int maxIterations = 35,
    double tol = 1e-4,
    double lambda = 1e-3,
  }) {
    if (devices.length < 3) {
      final initialMap = <String, EnuPoint>{
        for (final d in devices) d.deviceId: d.prior,
      };
      return NetworkAdjustmentResult(
        devicePositions: initialMap,
        rmsResidual: 999.0,
        converged: false,
        iterations: 0,
        quality: 'poor',
      );
    }

    final nDevices = devices.length;
    final deviceIndices = <String, int>{};
    for (var i = 0; i < nDevices; i++) {
      deviceIndices[devices[i].deviceId] = i;
    }

    // Filter valid pairwise ranges
    final validRanges = ranges.where((r) {
      return deviceIndices.containsKey(r.deviceAId) &&
          deviceIndices.containsKey(r.deviceBId) &&
          r.deviceAId != r.deviceBId;
    }).toList();

    // 2 unknowns per device: (east, north)
    final numUnknowns = nDevices * 2;
    var x = List<double>.filled(numUnknowns, 0.0);
    for (var i = 0; i < nDevices; i++) {
      x[2 * i] = devices[i].prior.east;
      x[2 * i + 1] = devices[i].prior.north;
    }

    final totalObs = 2 * nDevices + validRanges.length;
    var converged = false;
    var iter = 0;
    Matrix? finalCovariance;

    for (iter = 0; iter < maxIterations; iter++) {
      final J = Matrix(totalObs, numUnknowns);
      final r = Matrix(totalObs, 1);
      final weights = List<double>.filled(totalObs, 1.0);
      var row = 0;

      // 1. Device GNSS Priors
      for (var i = 0; i < nDevices; i++) {
        final d = devices[i];
        final curEast = x[2 * i];
        final curNorth = x[2 * i + 1];

        final resE = curEast - d.prior.east;
        final resN = curNorth - d.prior.north;

        final effectiveSigma = d.isFixed ? 1e-4 : math.max(0.01, d.sigma);
        final w = 1.0 / (effectiveSigma * effectiveSigma);

        // East row
        r.set(row, 0, resE);
        J.set(row, 2 * i, 1.0);
        weights[row] = w;
        row++;

        // North row
        r.set(row, 0, resN);
        J.set(row, 2 * i + 1, 1.0);
        weights[row] = w;
        row++;
      }

      // 2. Pairwise BLE Ranges
      for (final range in validRanges) {
        final i = deviceIndices[range.deviceAId]!;
        final j = deviceIndices[range.deviceBId]!;

        final de = x[2 * i] - x[2 * j];
        final dn = x[2 * i + 1] - x[2 * j + 1];
        final dist = math.sqrt(de * de + dn * dn);
        final safeDist = dist < 1e-6 ? 1e-6 : dist;

        final res = safeDist - range.distance;
        r.set(row, 0, res);

        J.set(row, 2 * i, de / safeDist);
        J.set(row, 2 * i + 1, dn / safeDist);
        J.set(row, 2 * j, -de / safeDist);
        J.set(row, 2 * j + 1, -dn / safeDist);

        final sigma = math.max(0.01, range.sigma);
        var w = 1.0 / (sigma * sigma);

        // Huber robust weighting
        final normRes = res.abs() / sigma;
        if (normRes > huberK) {
          w *= (huberK / normRes);
        }
        weights[row] = w;
        row++;
      }

      final W = Matrix.diagonal(weights);
      final jt = J.transpose();
      final N = (jt * W * J).addDiagonal(lambda);
      final grad = jt * W * r;

      final delta = N.solve(grad.scale(-1.0));
      if (delta == null) {
        break;
      }

      var maxDelta = 0.0;
      for (var k = 0; k < numUnknowns; k++) {
        final dVal = delta.get(k, 0);
        x[k] += dVal;
        if (dVal.abs() > maxDelta) {
          maxDelta = dVal.abs();
        }
      }

      if (maxDelta < tol) {
        converged = true;
        finalCovariance = (jt * W * J).addDiagonal(1e-6).inverse();
        break;
      }

      if (iter == maxIterations - 1) {
        finalCovariance = (jt * W * J).addDiagonal(1e-6).inverse();
      }
    }

    // Residual calculation on ranges
    var rangeResidualSq = 0.0;
    for (final range in validRanges) {
      final i = deviceIndices[range.deviceAId]!;
      final j = deviceIndices[range.deviceBId]!;
      final de = x[2 * i] - x[2 * j];
      final dn = x[2 * i + 1] - x[2 * j + 1];
      final dist = math.sqrt(de * de + dn * dn);
      final res = dist - range.distance;
      rangeResidualSq += res * res;
    }
    final rms = validRanges.isEmpty
        ? 0.0
        : math.sqrt(rangeResidualSq / validRanges.length);

    // Compute standard deviations from covariance
    final stdDevs = <String, double>{};
    final resultMap = <String, EnuPoint>{};

    for (var i = 0; i < nDevices; i++) {
      final dev = devices[i];
      final adjEast = x[2 * i];
      final adjNorth = x[2 * i + 1];
      resultMap[dev.deviceId] = EnuPoint(
        east: adjEast,
        north: adjNorth,
        up: dev.prior.up,
      );

      if (finalCovariance != null) {
        final varE = math.max(0.0, finalCovariance.get(2 * i, 2 * i));
        final varN = math.max(0.0, finalCovariance.get(2 * i + 1, 2 * i + 1));
        stdDevs[dev.deviceId] = math.sqrt(varE + varN);
      } else {
        stdDevs[dev.deviceId] = 999.0;
      }
    }

    final maxStdDev = stdDevs.values.isEmpty
        ? 0.0
        : stdDevs.values.reduce(math.max);

    String quality;
    if (!converged || rms > 3.0 || maxStdDev > 6.0) {
      quality = QualityFlag.poor;
    } else if (rms < 1.0 && maxStdDev <= 3.5) {
      quality = QualityFlag.good;
    } else {
      quality = QualityFlag.fair;
    }

    return NetworkAdjustmentResult(
      devicePositions: resultMap,
      rmsResidual: rms,
      converged: converged,
      iterations: iter + 1,
      quality: quality,
      standardDeviations: stdDevs,
    );
  }
}
