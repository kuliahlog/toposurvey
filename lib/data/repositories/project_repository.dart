import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class ProjectRepository {
  ProjectRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<Project>> watchAll() {
    return (_db.select(
      _db.projects,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).watch();
  }

  Stream<Project?> watchById(String id) {
    return (_db.select(
      _db.projects,
    )..where((table) => table.id.equals(id))).watchSingleOrNull();
  }

  Future<Project?> findById(String id) {
    return (_db.select(
      _db.projects,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<Project> create({
    required String name,
    String? description,
    double? benchmarkHeight,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await _db
        .into(_db.projects)
        .insert(
          ProjectsCompanion.insert(
            id: id,
            name: name,
            description: Value(description),
            benchmarkHeight: Value(benchmarkHeight),
            createdAt: now,
          ),
        );
    return (await findById(id))!;
  }

  Future<void> updateCalibration({
    required String projectId,
    double? benchmarkHeight,
    double? basePressureHpa,
  }) async {
    await (_db.update(
      _db.projects,
    )..where((table) => table.id.equals(projectId))).write(
      ProjectsCompanion(
        benchmarkHeight: Value(benchmarkHeight),
        basePressureHpa: Value(basePressureHpa),
      ),
    );
  }

  Future<void> deleteProject(String projectId) async {
    await _db.transaction(() async {
      final projectSessions = await (_db.select(
        _db.sessions,
      )..where((table) => table.projectId.equals(projectId))).get();
      final sessionIds = projectSessions.map((session) => session.id).toList();

      var epochIds = <String>[];
      if (sessionIds.isNotEmpty) {
        final epochs = await (_db.select(
          _db.epochs,
        )..where((table) => table.sessionId.isIn(sessionIds))).get();
        epochIds = epochs.map((epoch) => epoch.id).toList();
      }

      if (epochIds.isNotEmpty) {
        await (_db.delete(
          _db.gnssObservations,
        )..where((table) => table.epochId.isIn(epochIds))).go();
        await (_db.delete(
          _db.baroObservations,
        )..where((table) => table.epochId.isIn(epochIds))).go();
        await (_db.delete(
          _db.bleMeasurements,
        )..where((table) => table.epochId.isIn(epochIds))).go();
        await (_db.delete(
          _db.epochs,
        )..where((table) => table.id.isIn(epochIds))).go();
      }

      if (sessionIds.isNotEmpty) {
        await (_db.delete(
          _db.anchors,
        )..where((table) => table.sessionId.isIn(sessionIds))).go();
        await (_db.delete(
          _db.devices,
        )..where((table) => table.sessionId.isIn(sessionIds))).go();
        await (_db.delete(
          _db.sessions,
        )..where((table) => table.id.isIn(sessionIds))).go();
      }

      await (_db.delete(
        _db.surveyPoints,
      )..where((table) => table.projectId.equals(projectId))).go();
      await (_db.delete(
        _db.projects,
      )..where((table) => table.id.equals(projectId))).go();
    });
  }
}
