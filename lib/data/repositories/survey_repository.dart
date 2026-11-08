import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/models/point_draft.dart';
import '../database/app_database.dart';

class SurveyRepository {
  SurveyRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<SurveyPoint>> watchPoints(String projectId) {
    return (_db.select(_db.surveyPoints)
          ..where(
            (table) =>
                table.projectId.equals(projectId) &
                table.status.equals('active'),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .watch();
  }

  Future<List<SurveyPoint>> getPoints(String projectId) {
    return (_db.select(_db.surveyPoints)
          ..where(
            (table) =>
                table.projectId.equals(projectId) &
                table.status.equals('active'),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .get();
  }

  Future<Session> startSession(
    String projectId, {
    String mode = SessionMode.single,
  }) async {
    final sessionId = _uuid.v4();
    final deviceId = _uuid.v4();
    final now = DateTime.now();
    final code = _uuid.v4().replaceAll('-', '').substring(0, 6).toUpperCase();

    await _db.transaction(() async {
      await _db
          .into(_db.sessions)
          .insert(
            SessionsCompanion.insert(
              id: sessionId,
              projectId: projectId,
              mode: mode,
              code: code,
              masterDeviceId: Value(deviceId),
              startedAt: now,
            ),
          );
      await _db
          .into(_db.devices)
          .insert(
            DevicesCompanion.insert(
              id: deviceId,
              sessionId: sessionId,
              shortId: 1,
              role: DeviceRole.rover,
              name: 'Perangkat lokal',
            ),
          );
    });

    return (await (_db.select(
      _db.sessions,
    )..where((table) => table.id.equals(sessionId))).getSingle());
  }

  Future<SurveyPoint> addPoint({
    required String projectId,
    required String sessionId,
    required PointDraft draft,
  }) async {
    final project = await (_db.select(
      _db.projects,
    )..where((table) => table.id.equals(projectId))).getSingle();
    final session = await (_db.select(
      _db.sessions,
    )..where((table) => table.id.equals(sessionId))).getSingle();
    final deviceId = session.masterDeviceId ?? 'local-device';

    final pointId = _uuid.v4();
    final epochId = _uuid.v4();
    final now = DateTime.now();
    final epochCount = await _epochCount(sessionId);

    await _db.transaction(() async {
      await _db
          .into(_db.epochs)
          .insert(
            EpochsCompanion.insert(
              id: epochId,
              sessionId: sessionId,
              index: epochCount + 1,
              startedAt: draft.capturedAt,
              endedAt: Value(now),
              status: const Value('complete'),
            ),
          );

      await _db
          .into(_db.gnssObservations)
          .insert(
            GnssObservationsCompanion.insert(
              id: _uuid.v4(),
              epochId: epochId,
              deviceId: deviceId,
              lat: draft.latitude,
              lon: draft.longitude,
              ellipH: draft.ellipsoidHeight ?? draft.orthometricHeight,
              accuracyH: draft.accuracyH,
              accuracyV: Value(draft.accuracyV),
              sampleCount: draft.sampleCount,
              stdLat: draft.stdLat,
              stdLon: draft.stdLon,
              stdAlt: draft.stdAlt,
              createdAt: now,
            ),
          );

      if (draft.pressureHpa != null) {
        await _db
            .into(_db.baroObservations)
            .insert(
              BaroObservationsCompanion.insert(
                id: _uuid.v4(),
                epochId: epochId,
                deviceId: deviceId,
                pressureHpa: draft.pressureHpa!,
                relativeHeightM: Value(draft.relativeHeightM),
                basePressureHpa: Value(draft.basePressureHpa),
                createdAt: now,
              ),
            );
      }

      await _db
          .into(_db.surveyPoints)
          .insert(
            SurveyPointsCompanion.insert(
              id: pointId,
              projectId: projectId,
              sessionId: sessionId,
              epochId: Value(epochId),
              code: draft.code,
              layer: Value(draft.layer),
              description: Value(draft.description),
              lat: draft.latitude,
              lon: draft.longitude,
              orthoH: draft.orthometricHeight,
              accuracyH: draft.accuracyH,
              accuracyV: Value(draft.accuracyV),
              method: draft.method,
              quality: draft.quality,
              poleHeight: draft.poleHeight,
              createdAt: now,
              updatedAt: now,
            ),
          );

      if (project.originLat == null || project.originLon == null) {
        await (_db.update(
          _db.projects,
        )..where((table) => table.id.equals(projectId))).write(
          ProjectsCompanion(
            originLat: Value(draft.latitude),
            originLon: Value(draft.longitude),
            originEllipH: Value(draft.ellipsoidHeight),
          ),
        );
      }
    });

    return (await (_db.select(
      _db.surveyPoints,
    )..where((table) => table.id.equals(pointId))).getSingle());
  }

  Future<void> deletePoint(String pointId) async {
    await (_db.update(
      _db.surveyPoints,
    )..where((table) => table.id.equals(pointId))).write(
      SurveyPointsCompanion(
        status: const Value('deleted'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> _epochCount(String sessionId) async {
    final count = _db.epochs.id.count();
    final query = _db.selectOnly(_db.epochs)
      ..addColumns([count])
      ..where(_db.epochs.sessionId.equals(sessionId));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
