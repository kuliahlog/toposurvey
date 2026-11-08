import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/geo/geodesy.dart';
import 'package:toposurvey/core/geo/trilateration_solver.dart';

void main() {
  group('TrilaterationSolver', () {
    test('exact 2D trilateration locates target point', () {
      // Target at (5, 3)
      final anchors = [
        const AnchorObservation(
          position: EnuPoint(east: 0, north: 0, up: 0),
          distance: 5.83095189, // sqrt(25 + 9) = sqrt(34)
          sigma: 0.5,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 10, north: 0, up: 0),
          distance: 5.83095189, // sqrt(25 + 9) = sqrt(34)
          sigma: 0.5,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 5, north: 10, up: 0),
          distance: 7.0, // sqrt(0 + 49) = 7
          sigma: 0.5,
        ),
      ];

      final solver = TrilaterationSolver();
      final result = solver.solve2D(anchors: anchors);

      expect(result.converged, isTrue);
      expect(result.estimatedPosition.east, closeTo(5.0, 0.05));
      expect(result.estimatedPosition.north, closeTo(3.0, 0.05));
      expect(result.rmsResidual, lessThan(0.05));
      expect(result.quality, equals('good'));
    });

    test('overdetermined 4 anchors with GNSS prior', () {
      // Target at (12, 15)
      const targetE = 12.0;
      const targetN = 15.0;

      final anchorPositions = [
        const EnuPoint(east: 0, north: 0, up: 0),
        const EnuPoint(east: 25, north: 0, up: 0),
        const EnuPoint(east: 25, north: 30, up: 0),
        const EnuPoint(east: 0, north: 30, up: 0),
      ];

      final anchors = anchorPositions.map((pos) {
        final d = math.sqrt(
          math.pow(pos.east - targetE, 2) + math.pow(pos.north - targetN, 2),
        );
        return AnchorObservation(position: pos, distance: d, sigma: 0.8);
      }).toList();

      // Slightly noisy GNSS prior: (13, 14) with sigma = 5.0m
      const gnssPrior = EnuPoint(east: 13.0, north: 14.0, up: 0);

      final solver = TrilaterationSolver();
      final result = solver.solve2D(
        anchors: anchors,
        gnssPrior: gnssPrior,
        gnssSigma: 5.0,
      );

      expect(result.converged, isTrue);
      expect(result.estimatedPosition.east, closeTo(12.0, 0.1));
      expect(result.estimatedPosition.north, closeTo(15.0, 0.1));
      expect(result.horizontalAccuracy, lessThan(1.5));
      expect(result.quality, equals('good'));
    });

    test('rejects fewer than 3 anchors', () {
      final anchors = [
        const AnchorObservation(
          position: EnuPoint(east: 0, north: 0, up: 0),
          distance: 5.0,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 10, north: 0, up: 0),
          distance: 5.0,
        ),
      ];

      final solver = TrilaterationSolver();
      final result = solver.solve2D(anchors: anchors);

      expect(result.converged, isFalse);
      expect(result.quality, equals('poor'));
    });

    test('robust weighting handles single distance outlier', () {
      // Target at (5, 5)
      final anchors = [
        const AnchorObservation(
          position: EnuPoint(east: 0, north: 0, up: 0),
          distance: 7.071, // sqrt(25+25)
          sigma: 0.5,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 10, north: 0, up: 0),
          distance: 7.071,
          sigma: 0.5,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 10, north: 10, up: 0),
          distance: 7.071,
          sigma: 0.5,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 0, north: 10, up: 0),
          distance: 7.071,
          sigma: 0.5,
        ),
        // Bad outlier anchor distance: says 25m instead of ~7m
        const AnchorObservation(
          position: EnuPoint(east: 5, north: 12, up: 0),
          distance: 25.0,
          sigma: 1.0,
        ),
      ];

      final solver = TrilaterationSolver();
      final result = solver.solve2D(anchors: anchors);

      expect(result.converged, isTrue);
      // Because of Huber robust loss, the target should still be close to (5, 5)
      expect(result.estimatedPosition.east, closeTo(5.0, 0.8));
      expect(result.estimatedPosition.north, closeTo(5.0, 0.8));
    });

    test('collinear anchors with damping does not crash', () {
      // Collinear along the East axis
      final anchors = [
        const AnchorObservation(
          position: EnuPoint(east: 0, north: 0, up: 0),
          distance: 5.0,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 5, north: 0, up: 0),
          distance: 5.0,
        ),
        const AnchorObservation(
          position: EnuPoint(east: 10, north: 0, up: 0),
          distance: 5.0,
        ),
      ];

      final solver = TrilaterationSolver();
      final result = solver.solve2D(anchors: anchors);
      // Should handle collinear geometry without throwing exception
      expect(result, isNotNull);
    });
  });
}

