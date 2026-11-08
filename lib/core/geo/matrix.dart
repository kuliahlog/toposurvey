import 'dart:typed_data';

/// Pure-Dart matrix utility for geodesy and least-squares network adjustments.
class Matrix {
  Matrix(this.rows, this.cols, [Float64List? data])
      : _data = data ?? Float64List(rows * cols);

  final int rows;
  final int cols;
  final Float64List _data;

  factory Matrix.zeros(int rows, int cols) => Matrix(rows, cols);

  factory Matrix.identity(int n) {
    final m = Matrix(n, n);
    for (var i = 0; i < n; i++) {
      m.set(i, i, 1.0);
    }
    return m;
  }

  factory Matrix.fromRows(List<List<double>> rows) {
    final r = rows.length;
    final c = rows.first.length;
    final m = Matrix(r, c);
    for (var i = 0; i < r; i++) {
      for (var j = 0; j < c; j++) {
        m.set(i, j, rows[i][j]);
      }
    }
    return m;
  }

  factory Matrix.column(List<double> values) {
    final m = Matrix(values.length, 1);
    for (var i = 0; i < values.length; i++) {
      m.set(i, 0, values[i]);
    }
    return m;
  }

  factory Matrix.diagonal(List<double> diag) {
    final n = diag.length;
    final m = Matrix(n, n);
    for (var i = 0; i < n; i++) {
      m.set(i, i, diag[i]);
    }
    return m;
  }

  double get(int r, int c) => _data[r * cols + c];

  void set(int r, int c, double val) {
    _data[r * cols + c] = val;
  }

  Matrix transpose() {
    final res = Matrix(cols, rows);
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        res.set(j, i, get(i, j));
      }
    }
    return res;
  }

  Matrix operator +(Matrix other) {
    assert(rows == other.rows && cols == other.cols, 'Matrix dimensions must match');
    final res = Matrix(rows, cols);
    final count = rows * cols;
    for (var i = 0; i < count; i++) {
      res._data[i] = _data[i] + other._data[i];
    }
    return res;
  }

  Matrix operator -(Matrix other) {
    assert(rows == other.rows && cols == other.cols, 'Matrix dimensions must match');
    final res = Matrix(rows, cols);
    final count = rows * cols;
    for (var i = 0; i < count; i++) {
      res._data[i] = _data[i] - other._data[i];
    }
    return res;
  }

  Matrix scale(double s) {
    final res = Matrix(rows, cols);
    final count = rows * cols;
    for (var i = 0; i < count; i++) {
      res._data[i] = _data[i] * s;
    }
    return res;
  }

  Matrix operator *(Matrix other) {
    assert(cols == other.rows, 'Matrix inner dimensions must match: $cols vs ${other.rows}');
    final res = Matrix(rows, other.cols);
    for (var i = 0; i < rows; i++) {
      for (var k = 0; k < cols; k++) {
        final aik = get(i, k);
        if (aik == 0.0) continue;
        for (var j = 0; j < other.cols; j++) {
          res.set(i, j, res.get(i, j) + aik * other.get(k, j));
        }
      }
    }
    return res;
  }

  Matrix addDiagonal(double lambda) {
    assert(rows == cols, 'addDiagonal requires a square matrix');
    final res = Matrix(rows, cols, Float64List.fromList(_data));
    for (var i = 0; i < rows; i++) {
      res.set(i, i, res.get(i, i) + lambda);
    }
    return res;
  }

  /// Solves Ax = b using Gauss-Jordan elimination with partial pivoting.
  Matrix? solve(Matrix b) {
    assert(rows == cols, 'Solve requires a square matrix');
    assert(rows == b.rows, 'Dimension mismatch with RHS vector/matrix');
    final n = rows;
    final m = b.cols;

    // Augmented matrix [A | b]
    final aug = List.generate(
      n,
      (i) => List<double>.generate(n + m, (j) => j < n ? get(i, j) : b.get(i, j - n)),
    );

    for (var col = 0; col < n; col++) {
      // Find pivot
      var maxRow = col;
      var maxVal = aug[col][col].abs();
      for (var row = col + 1; row < n; row++) {
        final val = aug[row][col].abs();
        if (val > maxVal) {
          maxVal = val;
          maxRow = row;
        }
      }

      if (maxVal < 1e-12) {
        return null; // Singular matrix
      }

      // Swap rows
      if (maxRow != col) {
        final tmp = aug[col];
        aug[col] = aug[maxRow];
        aug[maxRow] = tmp;
      }

      // Normalize pivot row
      final pivot = aug[col][col];
      for (var j = col; j < n + m; j++) {
        aug[col][j] /= pivot;
      }

      // Eliminate column entries in other rows
      for (var row = 0; row < n; row++) {
        if (row != col) {
          final factor = aug[row][col];
          if (factor != 0.0) {
            for (var j = col; j < n + m; j++) {
              aug[row][j] -= factor * aug[col][j];
            }
          }
        }
      }
    }

    final x = Matrix(n, m);
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < m; j++) {
        x.set(i, j, aug[i][n + j]);
      }
    }
    return x;
  }

  /// Inverts the square matrix using Gauss-Jordan elimination.
  Matrix? inverse() {
    assert(rows == cols, 'Inverse requires a square matrix');
    return solve(Matrix.identity(rows));
  }
}
