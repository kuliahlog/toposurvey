import 'dart:async';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toposurvey/data/database/app_database.dart';
import 'package:toposurvey/data/repositories/project_repository.dart';
import 'package:toposurvey/data/repositories/survey_repository.dart';
import 'package:toposurvey/domain/services/barometer_service.dart';
import 'package:toposurvey/domain/services/export_service.dart';
import 'package:toposurvey/features/survey/capture_sheet.dart';
import 'package:toposurvey/providers/app_providers.dart';

Position fix(DateTime timestamp) => Position(
  longitude: 107.6,
  latitude: -6.9,
  timestamp: timestamp,
  accuracy: 5,
  altitude: 700,
  altitudeAccuracy: 8,
  hasAltitude: true,
  hasAltitudeAccuracy: true,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

void main() {
  for (final cadence in [1, 5]) {
    testWidgets(
      'capture saves and exports with updates every $cadence seconds',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final db = AppDatabase(NativeDatabase.memory());
        final positions = StreamController<Position>();
        final directory = (await tester.runAsync(
          () => Directory.systemTemp.createTemp('toposurvey-test-'),
        ))!;
        addTearDown(() async {
          await positions.close();
          await db.close();
          await directory.delete(recursive: true);
        });
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/path_provider'),
              (_) async => directory.path,
            );
        addTearDown(
          () => TestDefaultBinaryMessengerBinding
              .instance
              .defaultBinaryMessenger
              .setMockMethodCallHandler(
                const MethodChannel('plugins.flutter.io/path_provider'),
                null,
              ),
        );
        final project = (await tester.runAsync(
          () => ProjectRepository(db).create(name: 'Capture test'),
        ))!;
        final session = (await tester.runAsync(
          () => SurveyRepository(db).startSession(project.id),
        ))!;
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              databaseProvider.overrideWithValue(db),
              livePositionProvider.overrideWith((ref) => positions.stream),
              barometerProvider.overrideWith(
                (ref) => const Stream<BaroReading>.empty(),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: CaptureSheet(
                  project: project,
                  sessionId: session.id,
                  suggestedCode: 'TP-001',
                ),
              ),
            ),
          ),
        );
        final started = DateTime.now();
        positions.add(fix(started));
        await tester.pump();
        await tester.tap(find.text('Mulai Sampling'));
        for (var i = 1; i <= (cadence == 1 ? 60 : 80); i++) {
          if (i % cadence == 0) {
            positions.add(fix(started.add(Duration(seconds: i))));
          }
          await tester.pump(const Duration(seconds: 1));
        }
        await tester.ensureVisible(find.text('Simpan Titik'));
        await tester.tap(find.text('Simpan Titik'));
        await tester.pump();
        await tester.runAsync(() async {
          // Let the SQLite worker finish the save before querying the result.
          await Future<void>.delayed(const Duration(milliseconds: 200));
          final points = await SurveyRepository(db).getPoints(project.id);
          expect(points, hasLength(1));
          expect(points.single.orthoH, closeTo(698.5, 0.001));
          expect(points.single.method, 'gnss');
          final exporter = ExportService();
          final csv = await exporter.exportCsv(
            project: project,
            points: points,
          );
          final geojson = await exporter.exportGeoJson(
            project: project,
            points: points,
          );
          expect(await csv.readAsString(), contains('TP-001'));
          expect(await csv.readAsString(), contains('height_reference'));
          expect(await csv.readAsString(), contains('ellipsoidal'));
          expect(await geojson.readAsString(), contains('height_reference'));
          expect(await geojson.readAsString(), contains('698.5'));
        });
        await tester.pumpWidget(const SizedBox());
      },
    );
  }
}
