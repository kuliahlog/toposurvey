import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../data/database/app_database.dart';
import '../data/database/connection.dart';
import '../data/repositories/project_repository.dart';
import '../data/repositories/survey_repository.dart';
import '../domain/services/barometer_service.dart';
import '../domain/services/export_service.dart';
import '../domain/services/gnss_service.dart';
import '../domain/services/solver_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(openDatabaseConnection());
  ref.onDispose(database.close);
  return database;
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(databaseProvider));
});

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  return SurveyRepository(ref.watch(databaseProvider));
});

final gnssServiceProvider = Provider<GnssService>((ref) => GnssService());

final barometerServiceProvider = Provider<BarometerService>(
  (ref) => BarometerService(),
);

final exportServiceProvider = Provider<ExportService>((ref) => ExportService());

final solverServiceProvider = Provider<SolverService>((ref) => SolverService());

final projectsStreamProvider = StreamProvider.autoDispose<List<Project>>((ref) {
  return ref.watch(projectRepositoryProvider).watchAll();
});

final projectProvider = StreamProvider.autoDispose.family<Project?, String>((
  ref,
  projectId,
) {
  return ref.watch(projectRepositoryProvider).watchById(projectId);
});

final pointsStreamProvider = StreamProvider.autoDispose
    .family<List<SurveyPoint>, String>((ref, projectId) {
      return ref.watch(surveyRepositoryProvider).watchPoints(projectId);
    });

final sessionProvider = StreamProvider.autoDispose
    .family<Session?, String>((ref, sessionId) {
      return ref.watch(surveyRepositoryProvider).watchSession(sessionId);
    });

final anchorsStreamProvider = StreamProvider.autoDispose
    .family<List<Anchor>, String>((ref, sessionId) {
      return ref.watch(surveyRepositoryProvider).watchAnchors(sessionId);
    });

final livePositionProvider = StreamProvider.autoDispose<Position>((ref) {
  return ref.watch(gnssServiceProvider).watchPosition();
});

final barometerProvider = StreamProvider.autoDispose<BaroReading>((ref) {
  return ref
      .watch(barometerServiceProvider)
      .readings()
      .timeout(const Duration(seconds: 5));
});
