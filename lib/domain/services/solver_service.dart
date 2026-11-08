import '../../core/geo/geodesy.dart';
import '../../core/geo/network_adjustment_solver.dart';
import '../../core/geo/trilateration_solver.dart';

class GeoAnchorObservation {
  const GeoAnchorObservation({
    required this.position,
    required this.distance,
    this.sigma = 1.0,
    this.anchorId,
  });

  final GeoPoint position;
  final double distance;
  final double sigma;
  final String? anchorId;
}

class GeoDevicePrior {
  const GeoDevicePrior({
    required this.deviceId,
    required this.prior,
    this.sigma = 3.0,
    this.isFixed = false,
  });

  final String deviceId;
  final GeoPoint prior;
  final double sigma;
  final bool isFixed;
}

class TrilaterationSurveyResult {
  const TrilaterationSurveyResult({
    required this.estimatedGeo,
    required this.estimatedEnu,
    required this.solverResult,
    required this.poleHeight,
  });

  final GeoPoint estimatedGeo;
  final EnuPoint estimatedEnu;
  final TrilaterationResult solverResult;
  final double poleHeight;
}

class NetworkAdjustmentSurveyResult {
  const NetworkAdjustmentSurveyResult({
    required this.adjustedGeoPositions,
    required this.adjustedEnuPositions,
    required this.solverResult,
  });

  final Map<String, GeoPoint> adjustedGeoPositions;
  final Map<String, EnuPoint> adjustedEnuPositions;
  final NetworkAdjustmentResult solverResult;
}

/// Service that transforms Geodetic WGS84 positions to local ENU coordinate space,
/// runs the appropriate geodetic adjustment solver, and projects solutions back to WGS84.
class SolverService {
  SolverService({
    TrilaterationSolver? trilaterationSolver,
    NetworkAdjustmentSolver? networkAdjustmentSolver,
  })  : _trilaterationSolver = trilaterationSolver ?? TrilaterationSolver(),
        _networkAdjustmentSolver = networkAdjustmentSolver ?? NetworkAdjustmentSolver();

  final TrilaterationSolver _trilaterationSolver;
  final NetworkAdjustmentSolver _networkAdjustmentSolver;

  TrilaterationSurveyResult solveTrilateration({
    required GeoPoint origin,
    required List<GeoAnchorObservation> anchors,
    GeoPoint? gnssPrior,
    double? gnssSigma,
    double poleHeight = 0.0,
    double huberK = 1.5,
  }) {
    final enuAnchors = anchors.map((a) {
      final enu = Geodesy.toEnu(a.position, origin);
      return AnchorObservation(
        position: enu,
        distance: a.distance,
        sigma: a.sigma,
        anchorId: a.anchorId,
      );
    }).toList();

    EnuPoint? enuGnssPrior;
    if (gnssPrior != null) {
      enuGnssPrior = Geodesy.toEnu(gnssPrior, origin);
    }

    final result = _trilaterationSolver.solve2D(
      anchors: enuAnchors,
      gnssPrior: enuGnssPrior,
      gnssSigma: gnssSigma,
      huberK: huberK,
    );

    // Compute ground height: (sensor height - pole height)
    final sensorGeo = Geodesy.fromEnu(result.estimatedPosition, origin);
    final groundGeo = GeoPoint(
      latitude: sensorGeo.latitude,
      longitude: sensorGeo.longitude,
      height: sensorGeo.height - poleHeight,
    );

    return TrilaterationSurveyResult(
      estimatedGeo: groundGeo,
      estimatedEnu: result.estimatedPosition,
      solverResult: result,
      poleHeight: poleHeight,
    );
  }

  NetworkAdjustmentSurveyResult solveNetworkAdjustment({
    required GeoPoint origin,
    required List<GeoDevicePrior> devices,
    required List<PairwiseRange> ranges,
    double huberK = 1.5,
  }) {
    final enuDevices = devices.map((d) {
      final enu = Geodesy.toEnu(d.prior, origin);
      return DevicePrior(
        deviceId: d.deviceId,
        prior: enu,
        sigma: d.sigma,
        isFixed: d.isFixed,
      );
    }).toList();

    final result = _networkAdjustmentSolver.solve(
      devices: enuDevices,
      ranges: ranges,
      huberK: huberK,
    );

    final adjustedGeo = <String, GeoPoint>{};
    for (final entry in result.devicePositions.entries) {
      adjustedGeo[entry.key] = Geodesy.fromEnu(entry.value, origin);
    }

    return NetworkAdjustmentSurveyResult(
      adjustedGeoPositions: adjustedGeo,
      adjustedEnuPositions: result.devicePositions,
      solverResult: result,
    );
  }
}
