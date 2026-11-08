import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/geo/geodesy.dart';
import 'package:toposurvey/core/geo/network_adjustment_solver.dart';
import 'package:toposurvey/domain/services/solver_service.dart';

void main() {
  group('SolverService', () {
    const origin = GeoPoint(latitude: -6.9175, longitude: 107.6191, height: 750.0);
    final service = SolverService();

    test('solveTrilateration converts GeoPoints to ENU and back to GeoPoint', () {
      // 3 anchors offset by ENU
      final anchorEnu1 = const EnuPoint(east: 0, north: 0, up: 0);
      final anchorEnu2 = const EnuPoint(east: 10, north: 0, up: 0);
      final anchorEnu3 = const EnuPoint(east: 5, north: 10, up: 0);

      final geoA1 = Geodesy.fromEnu(anchorEnu1, origin);
      final geoA2 = Geodesy.fromEnu(anchorEnu2, origin);
      final geoA3 = Geodesy.fromEnu(anchorEnu3, origin);

      // Target at ENU (5, 3)
      final anchors = [
        GeoAnchorObservation(position: geoA1, distance: 5.83095, sigma: 0.5),
        GeoAnchorObservation(position: geoA2, distance: 5.83095, sigma: 0.5),
        GeoAnchorObservation(position: geoA3, distance: 7.0, sigma: 0.5),
      ];

      final result = service.solveTrilateration(
        origin: origin,
        anchors: anchors,
        poleHeight: 1.5,
      );

      expect(result.solverResult.converged, isTrue);
      expect(result.estimatedEnu.east, closeTo(5.0, 0.05));
      expect(result.estimatedEnu.north, closeTo(3.0, 0.05));

      final backToEnu = Geodesy.toEnu(result.estimatedGeo, origin);
      expect(backToEnu.east, closeTo(5.0, 0.05));
      expect(backToEnu.north, closeTo(3.0, 0.05));
    });

    test('solveNetworkAdjustment translates multiple GeoPoints and BLE ranges', () {
      final posA = Geodesy.fromEnu(const EnuPoint(east: 0, north: 0, up: 0), origin);
      final posB = Geodesy.fromEnu(const EnuPoint(east: 6, north: 0, up: 0), origin);
      final posC = Geodesy.fromEnu(const EnuPoint(east: 3, north: 5.196, up: 0), origin);

      final devices = [
        GeoDevicePrior(deviceId: 'dev1', prior: posA, sigma: 1.0),
        GeoDevicePrior(deviceId: 'dev2', prior: posB, sigma: 1.0),
        GeoDevicePrior(deviceId: 'dev3', prior: posC, sigma: 1.0),
      ];

      final ranges = [
        const PairwiseRange(deviceAId: 'dev1', deviceBId: 'dev2', distance: 6.0),
        const PairwiseRange(deviceAId: 'dev2', deviceBId: 'dev3', distance: 6.0),
        const PairwiseRange(deviceAId: 'dev3', deviceBId: 'dev1', distance: 6.0),
      ];

      final result = service.solveNetworkAdjustment(
        origin: origin,
        devices: devices,
        ranges: ranges,
      );

      expect(result.solverResult.converged, isTrue);
      expect(result.adjustedGeoPositions.length, equals(3));
      expect(result.adjustedEnuPositions.length, equals(3));
    });
  });
}
