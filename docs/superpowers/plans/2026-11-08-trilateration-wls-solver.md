# Trilateration and WLS Solver Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement pure-Dart mathematical solvers for 2D/3D Weighted Least-Squares (WLS) Trilateration and 3-device Network Adjustment with unit tests, error metrics, and domain service integration.

**Architecture:** Pure-Dart linear algebra matrix module + Trilateration Solver (Gauss-Newton with Levenberg-Marquardt damping) + 3-Device Joint Network Adjustment Solver running on local ENU coordinates, encapsulated behind a `SolverService` registered in Riverpod.

**Tech Stack:** Dart 3.13+, Flutter test framework, Drift ORM, existing `Geodesy` ENU transformations.

**Spec:** `toposurvey/docs/PRD.md` (Sections 11.4 & 11.5).

## Global Constraints

- Dart pure logic for solvers: zero Flutter UI dependencies in `core/geo` to enable fast, headless unit testing.
- Offline-first: solvers must execute synchronously or in microtasks within < 2 seconds on mid-range Android devices (NFR-02).
- Coordinates: Solvers operate in Local Tangent Plane (ENU in meters) and convert back to WGS84 Geodetic (`GeoPoint`) via `Geodesy.fromEnu`.
- Quality thresholds: residual RMS and covariance-based standard deviation must output quality flags (`good`, `fair`, `poor`) adhering to `AppConstants`.

## Review Focus

1. Near-collinear anchor geometry leading to singular normal matrices: damped Levenberg-Marquardt ensures numerical stability and returns `converged: false` or low quality rather than crashing.
2. Noisy or outlier BLE distance observations: solver uses robust weighting / Huber loss to prevent 1 bad RSSI sample from corrupting the coordinate fix.
3. Minimum anchor requirement: solver strictly rejects inputs with fewer than 3 non-degenerate anchor observations.
4. Scale consistency: ENU distances in meters match GNSS and BLE metric units.
5. Invertibility check: matrix inverse checks determinant or singularity pivot before division.

---

## Tasks

### Task 1: Pure-Dart Matrix Utility (`lib/core/geo/matrix.dart`)

**Files:**
- Create: `toposurvey/lib/core/geo/matrix.dart`
- Test: `toposurvey/test/core/geo/matrix_test.dart`

- [ ] **Step 1:** Write unit tests in `test/core/geo/matrix_test.dart` for matrix creation, addition, subtraction, transpose, multiplication, Gauss-Jordan inversion, and linear system solving ($A x = b$).
- [ ] **Step 2:** Run `flutter test test/core/geo/matrix_test.dart` to verify it fails (Red).
- [ ] **Step 3:** Implement `Matrix` class in `lib/core/geo/matrix.dart` supporting:
  - Flat `Float64List` internal buffer.
  - Basic operations: `transpose()`, `operator *`, `operator +`, `operator -`, `scale()`.
  - Inversion via Gauss-Jordan elimination with partial pivoting.
  - System solver `solve(Matrix b)`.
  - Identity matrix generator `Matrix.identity(int n)`.
  - Diagonal dampener for Levenberg-Marquardt: `addDiagonal(double lambda)`.
- [ ] **Step 4:** Run `flutter test test/core/geo/matrix_test.dart` to verify all tests pass (Green).
- [ ] **Step 5:** Commit: `git commit -m "feat(geo): add pure-Dart matrix mathematics utility"`.

---

### Task 2: 2D/3D WLS Trilateration Solver (`lib/core/geo/trilateration_solver.dart`)

**Files:**
- Create: `toposurvey/lib/core/geo/trilateration_solver.dart`
- Test: `toposurvey/test/core/geo/trilateration_solver_test.dart`

- [ ] **Step 1:** Write unit tests in `test/core/geo/trilateration_solver_test.dart`:
  - Exact 2D trilateration with 3 anchors (e.g. triangle at (0,0), (10,0), (5,8.66) locating target at (5, 2.88)).
  - Overdetermined trilateration with 4+ anchors with Gaussian noise.
  - Trilateration with GNSS prior constraint.
  - Degenerate collinear anchors handling (graceful failure / high uncertainty).
  - Outlier rejection / robust weighting test.
- [ ] **Step 2:** Run `flutter test test/core/geo/trilateration_solver_test.dart` to verify it fails (Red).
- [ ] **Step 3:** Implement `TrilaterationSolver` and `TrilaterationResult`:
  - `AnchorObservation(EnuPoint position, double distance, double sigma)`
  - Iterative Gauss-Newton with Levenberg-Marquardt damping ($\lambda$).
  - Huber loss weighting for range residuals $r_i = \|p - a_i\| - d_i$.
  - Covariance calculation $C = (J^T W J)^{-1}$ for horizontal standard error $\sigma_H = \sqrt{C_{0,0} + C_{1,1}}$.
  - RMS residual calculation.
  - Quality classification (`good` if RMS < 1.5m and $\sigma_H < 2.0\text{m}$, `fair` if RMS < 3.0m, else `poor`).
- [ ] **Step 4:** Run `flutter test test/core/geo/trilateration_solver_test.dart` and ensure all tests pass (Green).
- [ ] **Step 5:** Commit: `git commit -m "feat(geo): implement WLS trilateration solver with robust weighting"`.

---

### Task 3: 3-Device Joint Network Adjustment Solver (`lib/core/geo/network_adjustment_solver.dart`)

**Files:**
- Create: `toposurvey/lib/core/geo/network_adjustment_solver.dart`
- Test: `toposurvey/test/core/geo/network_adjustment_solver_test.dart`

- [ ] **Step 1:** Write unit tests in `test/core/geo/network_adjustment_solver_test.dart`:
  - 3 devices in equilateral triangle with GNSS priors + pairwise BLE distances.
  - Test case where Device A is a fixed base station.
  - Test with noisy GNSS and accurate BLE distances improving overall geometry.
  - Residual RMS and per-device error bounds.
- [ ] **Step 2:** Run `flutter test test/core/geo/network_adjustment_solver_test.dart` to verify it fails (Red).
- [ ] **Step 3:** Implement `NetworkAdjustmentSolver` and `NetworkAdjustmentResult`:
  - Parameter vector: coordinates for all 3 devices $(e_A, n_A, e_B, n_B, e_C, n_C)$ in ENU.
  - Observation equations for GNSS priors and pairwise range observations ($A\leftrightarrow B$, $B\leftrightarrow C$, $C\leftrightarrow A$).
  - Joint normal equations setup: $(J^T W J + \lambda I) \Delta x = -J^T W r$.
  - Extraction of adjusted positions and standard deviations.
- [ ] **Step 4:** Run `flutter test test/core/geo/network_adjustment_solver_test.dart` and verify all tests pass (Green).
- [ ] **Step 5:** Commit: `git commit -m "feat(geo): implement 3-device joint network adjustment solver"`.

---

### Task 4: Solver Service & Domain Integration (`lib/domain/services/solver_service.dart`)

**Files:**
- Create: `toposurvey/lib/domain/services/solver_service.dart`
- Modify: `toposurvey/lib/providers/app_providers.dart`
- Test: `toposurvey/test/domain/services/solver_service_test.dart`

- [ ] **Step 1:** Write unit test in `test/domain/services/solver_service_test.dart` testing the complete flow:
  - Converting GeoPoints to ENU using project origin.
  - Calling TrilaterationSolver and translating result back to `GeoPoint` (WGS84) and `PointDraft`.
  - Testing NetworkAdjustment for 3 devices and generating 3 `PointDraft`s.
- [ ] **Step 2:** Run `flutter test test/domain/services/solver_service_test.dart` to verify it fails (Red).
- [ ] **Step 3:** Implement `SolverService` and register `solverServiceProvider` in `app_providers.dart`.
- [ ] **Step 4:** Run all tests across the entire project (`flutter test`) and verify 100% pass rate.
- [ ] **Step 5:** Commit: `git commit -m "feat(domain): integrate solver service with geodesy and app providers"`.
