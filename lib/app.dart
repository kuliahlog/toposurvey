import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'features/projects/home_screen.dart';
import 'features/projects/project_detail_screen.dart';
import 'features/sensors/sensor_check_screen.dart';
import 'features/survey/survey_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/sensors',
        builder: (context, state) => const SensorCheckScreen(),
      ),
      GoRoute(
        path: '/project/:id',
        builder: (context, state) =>
            ProjectDetailScreen(projectId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'survey',
            builder: (context, state) {
              final sessionId = state.uri.queryParameters['session'];
              if (sessionId == null || sessionId.isEmpty) {
                return const Scaffold(
                  body: Center(child: Text('Sesi survey tidak ditemukan.')),
                );
              }
              return SurveyScreen(
                projectId: state.pathParameters['id']!,
                sessionId: sessionId,
              );
            },
          ),
        ],
      ),
    ],
  );
});

class TopoSurveyApp extends ConsumerWidget {
  const TopoSurveyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'TopoSurvey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
