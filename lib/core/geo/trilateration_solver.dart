import 'dart:math' as math;

import 'geodesy.dart';
import 'matrix.dart';

class AnchorObservation {
  const AnchorObservation({
    required this.position,
    required this.distance,
    this.sigma = 1.0,
    this.anchorId,
  });

  final EnuPoint position;
  final double distance;
  final double sigma;
  final String? anchorId;
}

class TrilaterationResult {
  const TrilaterationResult({
    required this.estimatedPosition,
    required this.rmsResidual,
    required this.horizontalAccuracy,
    required this.iterations,
    required this.converged,
    required this.quality,
    this.residuals = const [],
  });

  final EnuPoint estimatedPosition;
  final double rmsResidual;
  final double horizontalAccuracy;
  final int iterations;
  final bool converged;
  final String quality; // 'good', 'fair', 'poor'
  final List<double> residuals;
}

/// Weighted Least-Squares (WLS) Trilateration solver with Levenberg-Marquardt damping
/// and Huber robust weighting.
class TrilaterationSolver {
  TrilaterationResult solve2D({
    required List<AnchorObservation> anchors,
    EnuPoint? gnssPrior,
    double? gnssSigma,
    double huberK = 1.5,
    int maxIterations = 30,
    double tol = 1e-4,
    double lambda = 1e-3,
  }) {
    if (anchors.length < 3) {
      return TrilaterationResult(
        estimatedPosition: gnssPrior ?? const EnuPoint(east: 0, north: 0, up: 0),
        rmsResidual: 999.0,
        horizontalAccuracy: 999.0,
        iterations: 0,
        converged: false,
        quality: 'poor',
      );
    }

    // Initial position guess: GNSS prior or centroid of anchors
    var estEast = gnssPrior?.east ??
        (anchors.map((a) => a.position.east).reduce((a, b) => a + b) / anchors.length);
    var estNorth = gnssPrior?.north ??
        (anchors.map((a) => a.position.north).reduce((a, b) => a + b) / anchors.length);
    final estUp = gnssPrior?.up ?? 0.0;

    var converged = false;
    var iter = 0;
    Matrix? finalCovariance;
    final finalResiduals = <double>[];

    final hasGnssPrior = gnssPrior != null && gnssSigma != null && gnssSigma > 0;
    final totalObs = anchors.length + (hasGnssPrior ? 2 : 0);

    for (iter = 0; iter < maxIterations; iter++) {
      final J = Matrix(totalObs, 2);
      final r = Matrix(totalObs, 1);
      final weights = List<double>.filled(totalObs, 1.0);

      for (var i = 0; i < anchors.length; i++) {
        final a = anchors[i];
        final de = estEast - a.position.east;
        final dn = estNorth - a.position.north;
        final dist = math.sqrt(de * de + dn * dn);
        final safeDist = dist < 1e-6 ? 1e-6 : dist;

        final residual = safeDist - a.distance;
        r.set(i, 0, residual);

        // Jacobian: dr/de and dr/dn
        J.set(i, 0, de / safeDist);
        J.set(i, 1, dn / safeDist);

        final sigma = a.sigma <= 0 ? 1.0 : a.sigma;
        var w = 1.0 / (sigma * sigma);

        // Huber robust loss
        final normalizedResidual = residual.abs() / sigma;
        if (normalizedResidual > huberK) {
          w *= (huberK / normalizedResidual);
        }
        weights[i] = w;
      }

      if (hasGnssPrior) {
        final idxE = anchors.length;
        final idxN = anchors.length + 1;
        final gnssW = 1.0 / (gnssSigma * gnssSigma);

        r.set(idxE, 0, estEast - gnssPrior.east);
        J.set(idxE, 0, 1.0);
        J.set(idxE, 1, 0.0);
        weights[idxE] = gnssW;

        r.set(idxN, 0, estNorth - gnssPrior.north);
        J.set(idxN, 0, 0.0);
        J.set(idxN, 1, 1.0);
        weights[idxN] = gnssW;
      }

      final W = Matrix.diagonal(weights);
      final jt = J.transpose();
      final N = (jt * W * J).addDiagonal(lambda);
      final grad = jt * W * r;

      final delta = N.solve(grad.scale(-1.0));
      if (delta == null) {
        break; // Singular matrix
      }

      final dEast = delta.get(0, 0);
      final dNorth = delta.get(1, 0);

      estEast += dEast;
      estNorth += dNorth;

      if (math.sqrt(dEast * dEast + dNorth * dNorth) < tol) {
        converged = true;
        finalCovariance = (jt * W * J).addDiagonal(1e-6).inverse();
        break;
      }

      if (iter == maxIterations - 1) {
        finalCovariance = (jt * W * J).addDiagonal(1e-6).inverse();
      }
    }

    // Calculate final residuals on anchor observations
    var sumSq = 0.0;
    for (final a in anchors) {
      final de = estEast - a.position.east;
      final dn = estNorth - a.position.north;
      final dist = math.sqrt(de * de + dn * dn);
      final res = dist - a.distance;
      finalResiduals.add(res);
      sumSq += res * res;
    }
    final rms = math.sqrt(sumSq / anchors.length);

    double horizontalAccuracy;
    if (finalCovariance != null) {
      final varE = math.max(0.0, finalCovariance.get(0, 0));
      final varN = math.max(0.0, finalCovariance.get(1, 1));
      horizontalAccuracy = math.sqrt(varE + varN);
    } else {
      horizontalAccuracy = 999.0;
    }

    String quality;
    if (!converged || rms > 4.0 || horizontalAccuracy > 5.0) {
      quality = 'poor';
    } else if (rms < 1.0 && horizontalAccuracy < 2.0) {
      quality = 'good';
    } else {
      quality = 'fair';
    }

    return TrilaterationResult(
      estimatedPosition: EnuPoint(east: estEast, north: estNorth, up: estUp),
      rmsResidual: rms,
      horizontalAccuracy: horizontalAccuracy,
      iterations: iter + 1,
      converged: converged,
      quality: quality,
      residuals: finalResiduals,
    );
  }
}
