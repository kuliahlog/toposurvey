import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/geo/matrix.dart';

void main() {
  group('Matrix', () {
    test('creates zero and identity matrices correctly', () {
      final zero = Matrix.zeros(2, 3);
      expect(zero.rows, 2);
      expect(zero.cols, 3);
      expect(zero.get(0, 0), 0.0);
      expect(zero.get(1, 2), 0.0);

      final identity = Matrix.identity(3);
      expect(identity.rows, 3);
      expect(identity.cols, 3);
      expect(identity.get(0, 0), 1.0);
      expect(identity.get(1, 1), 1.0);
      expect(identity.get(2, 2), 1.0);
      expect(identity.get(0, 1), 0.0);
    });

    test('matrix addition, subtraction, and scalar multiplication', () {
      final a = Matrix.fromRows([
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
      final b = Matrix.fromRows([
        [5.0, 6.0],
        [7.0, 8.0],
      ]);

      final sum = a + b;
      expect(sum.get(0, 0), 6.0);
      expect(sum.get(0, 1), 8.0);
      expect(sum.get(1, 0), 10.0);
      expect(sum.get(1, 1), 12.0);

      final diff = b - a;
      expect(diff.get(0, 0), 4.0);
      expect(diff.get(1, 1), 4.0);

      final scaled = a.scale(2.0);
      expect(scaled.get(0, 0), 2.0);
      expect(scaled.get(1, 1), 8.0);
    });

    test('matrix transpose', () {
      final a = Matrix.fromRows([
        [1.0, 2.0, 3.0],
        [4.0, 5.0, 6.0],
      ]);
      final t = a.transpose();
      expect(t.rows, 3);
      expect(t.cols, 2);
      expect(t.get(0, 0), 1.0);
      expect(t.get(1, 0), 2.0);
      expect(t.get(2, 0), 3.0);
      expect(t.get(0, 1), 4.0);
      expect(t.get(2, 1), 6.0);
    });

    test('matrix multiplication', () {
      final a = Matrix.fromRows([
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
      final b = Matrix.fromRows([
        [2.0, 0.0],
        [1.0, 2.0],
      ]);
      final prod = a * b;
      // [1*2 + 2*1, 1*0 + 2*2] = [4, 4]
      // [3*2 + 4*1, 3*0 + 4*2] = [10, 8]
      expect(prod.rows, 2);
      expect(prod.cols, 2);
      expect(prod.get(0, 0), 4.0);
      expect(prod.get(0, 1), 4.0);
      expect(prod.get(1, 0), 10.0);
      expect(prod.get(1, 1), 8.0);
    });

    test('matrix inversion for 2x2 and 3x3 matrices', () {
      final a = Matrix.fromRows([
        [4.0, 7.0],
        [2.0, 6.0],
      ]);
      final inv = a.inverse();
      expect(inv, isNotNull);

      final prod = a * inv!;
      expect(prod.get(0, 0), closeTo(1.0, 1e-9));
      expect(prod.get(0, 1), closeTo(0.0, 1e-9));
      expect(prod.get(1, 0), closeTo(0.0, 1e-9));
      expect(prod.get(1, 1), closeTo(1.0, 1e-9));
    });

    test('linear system solving Ax = b', () {
      // 2x + y = 5
      // x + 3y = 5
      // Solution: x = 2, y = 1
      final a = Matrix.fromRows([
        [2.0, 1.0],
        [1.0, 3.0],
      ]);
      final b = Matrix.column([5.0, 5.0]);
      final x = a.solve(b);

      expect(x, isNotNull);
      expect(x!.get(0, 0), closeTo(2.0, 1e-9));
      expect(x.get(1, 0), closeTo(1.0, 1e-9));
    });

    test('addDiagonal for Levenberg-Marquardt damping', () {
      final a = Matrix.fromRows([
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
      final damped = a.addDiagonal(0.5);
      expect(damped.get(0, 0), 1.5);
      expect(damped.get(0, 1), 2.0);
      expect(damped.get(1, 0), 3.0);
      expect(damped.get(1, 1), 4.5);
    });

    test('singular matrix returns null on inverse or solve', () {
      final singular = Matrix.fromRows([
        [1.0, 2.0],
        [2.0, 4.0],
      ]);
      expect(singular.inverse(), isNull);
      expect(singular.solve(Matrix.column([1.0, 2.0])), isNull);
    });
  });
}

