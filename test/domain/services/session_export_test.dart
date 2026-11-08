import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/constants/app_constants.dart';
import 'package:toposurvey/data/database/app_database.dart';
import 'package:toposurvey/domain/services/export_service.dart';

void main() {
  group('ExportService Session JSON', () {
    final exporter = ExportService();
    final now = DateTime.utc(2026, 11, 8, 12, 0, 0);

    final testProject = Project(
      id: 'proj-1',
      name: 'Kampus SIG',
      datumMode: 'local',
      createdAt: now,
    );

    final testSession = Session(
      id: 'sess-1',
      projectId: 'proj-1',
      mode: SessionMode.virtualAnchor,
      code: 'ABC123',
      startedAt: now,
      status: 'active',
    );

    final testAnchors = [
      Anchor(
        id: 'anc-1',
        sessionId: 'sess-1',
        label: 'A1',
        lat: -6.9175,
        lon: 107.6191,
        ellipH: 750.0,
        createdAt: now,
        source: 'gnss',
        isFixed: true,
      ),
      Anchor(
        id: 'anc-2',
        sessionId: 'sess-1',
        label: 'A2',
        lat: -6.9174,
        lon: 107.6192,
        ellipH: 750.5,
        createdAt: now,
        source: 'gnss',
        isFixed: true,
      ),
    ];

    test('generateSessionJson produces valid JSON payload', () {
      final jsonStr = exporter.generateSessionJson(
        project: testProject,
        session: testSession,
        anchors: testAnchors,
        points: const [],
      );

      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      expect(map['app'], equals('TopoSurvey'));
      expect(map['version'], equals(1));
      expect(map['session']['id'], equals('sess-1'));
      expect(map['session']['mode'], equals(SessionMode.virtualAnchor));
      expect((map['anchors'] as List).length, equals(2));
      expect(map['anchors'][0]['label'], equals('A1'));
    });

    test('parseSessionJson decodes JSON into structured ImportSessionData', () {
      final jsonStr = exporter.generateSessionJson(
        project: testProject,
        session: testSession,
        anchors: testAnchors,
        points: const [],
      );

      final parsed = exporter.parseSessionJson(jsonStr);
      expect(parsed, isNotNull);
      expect(parsed!.sessionCode, equals('ABC123'));
      expect(parsed.sessionMode, equals(SessionMode.virtualAnchor));
      expect(parsed.anchors.length, equals(2));
      expect(parsed.anchors[0].label, equals('A1'));
      expect(parsed.anchors[0].lat, equals(-6.9175));
    });

    test('parseSessionJson returns null on invalid JSON format', () {
      expect(exporter.parseSessionJson('invalid json string'), isNull);
      expect(exporter.parseSessionJson('{"app": "OtherApp"}'), isNull);
    });
  });
}
