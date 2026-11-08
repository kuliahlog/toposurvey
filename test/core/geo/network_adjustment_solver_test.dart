import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/geo/geodesy.dart';
import 'package:toposurvey/core/geo/network_adjustment_solver.dart';

void main() {
  group('NetworkAdjustmentSolver', () {
    test('adjusts 3 devices in triangle configuration with exact distances', () {
      // True positions:
      // A at (0, 0)
      // B at (6, 0)
      // C at (3, 5.196) (Equilateral triangle side 6m)
      const trueA = EnuPoint(east: 0, north: 0, up: 0);
      const trueB = EnuPoint(east: 6, north: 0, up: 0);
      const trueC = EnuPoint(east: 3, north: 5.1961524, up: 0);

      // Noisy GNSS priors (error ~2m)
      const gnssA = EnuPoint(east: 0.5, north: -0.8, up: 0);
      const gnssB = EnuPoint(east: 6.8, north: 0.7, up: 0);
      const gnssC = EnuPoint(east: 2.2, north: 5.9, up: 0);

      final devices = [
        const DevicePrior(deviceId: 'devA', prior: gnssA, sigma: 3.0),
        const DevicePrior(deviceId: 'devB', prior: gnssB, sigma: 3.0),
        const DevicePrior(deviceId: 'devC', prior: gnssC, sigma: 3.0),
      ];

      // Precise BLE pairwise measurements (sigma = 0.3m)
      final ranges = [
        const PairwiseRange(deviceAId: 'devA', deviceBId: 'devB', distance: 6.0, sigma: 0.3),
        const PairwiseRange(deviceAId: 'devB', deviceBId: 'devC', distance: 6.0, sigma: 0.3),
        const PairwiseRange(deviceAId: 'devC', deviceBId: 'devA', distance: 6.0, sigma: 0.3),
      ];

      final solver = NetworkAdjustmentSolver();
      final result = solver.solve(devices: devices, ranges: ranges);

      expect(result.converged, isTrue);
      expect(result.quality, equals('good'));
      expect(result.devicePositions.length, equals(3));

      final adjA = result.devicePositions['devA']!;
      final adjB = result.devicePositions['devB']!;
      final adjC = result.devicePositions['devC']!;

      // The distance between adjusted points should match the 6m BLE range closely
      final distAB = math.sqrt(
        math.pow(adjA.east - adjB.east, 2) + math.pow(adjA.north - adjB.north, 2),
      );
      final distBC = math.sqrt(
        math.pow(adjB.east - adjC.east, 2) + math.pow(adjB.north - adjC.north, 2),
      );
      final distCA = math.sqrt(
        math.pow(adjC.east - adjA.east, 2) + math.pow(adjC.north - adjA.north, 2),
      );

      expect(distAB, closeTo(6.0, 0.1));
      expect(distBC, closeTo(6.0, 0.1));
      expect(distCA, closeTo(6.0, 0.1));
      expect(result.rmsResidual, lessThan(0.5));
    });

    test('fixed base station preserves base location and rotates network', () {
      // Device A is a fixed benchmark with very small sigma
      const baseA = EnuPoint(east: 100, north: 200, up: 10);
      const gnssB = EnuPoint(east: 110.5, north: 201.0, up: 10);
      const gnssC = EnuPoint(east: 100.2, north: 211.2, up: 10);

      final devices = [
        const DevicePrior(deviceId: 'base', prior: baseA, sigma: 0.001, isFixed: true),
        const DevicePrior(deviceId: 'roverB', prior: gnssB, sigma: 4.0),
        const DevicePrior(deviceId: 'roverC', prior: gnssC, sigma: 4.0),
      ];

      // Right-angled triangle: base to roverB = 10m, base to roverC = 10m, roverB to roverC = 14.142m
      final ranges = [
        const PairwiseRange(deviceAId: 'base', deviceBId: 'roverB', distance: 10.0, sigma: 0.2),
        const PairwiseRange(deviceAId: 'base', deviceBId: 'roverC', distance: 10.0, sigma: 0.2),
        const PairwiseRange(deviceAId: 'roverB', deviceBId: 'roverC', distance: 14.142, sigma: 0.3),
      ];

      final solver = NetworkAdjustmentSolver();
      final result = solver.solve(devices: devices, ranges: ranges);

      expect(result.converged, isTrue);
      final adjBase = result.devicePositions['base']!;
      expect(adjBase.east, closeTo(100.0, 0.01));
      expect(adjBase.north, closeTo(200.0, 0.01));

      final adjB = result.devicePositions['roverB']!;
      final distBaseB = math.sqrt(
        math.pow(adjBase.east - adjB.east, 2) + math.pow(adjBase.north - adjB.north, 2),
      );
      expect(distBaseB, closeTo(10.0, 0.1));
    });

    test('returns unconverged when fewer than 3 devices', () {
      final devices = [
        const DevicePrior(deviceId: 'devA', prior: EnuPoint(east: 0, north: 0, up: 0)),
        const DevicePrior(deviceId: 'devB', prior: EnuPoint(east: 5, north: 0, up: 0)),
      ];
      final ranges = [
        const PairwiseRange(deviceAId: 'devA', deviceBId: 'devB', distance: 5.0),
      ];

      final solver = NetworkAdjustmentSolver();
      final result = solver.solve(devices: devices, ranges: ranges);

      expect(result.converged, isFalse);
      expect(result.quality, equals('poor'));
    });
  });
}
