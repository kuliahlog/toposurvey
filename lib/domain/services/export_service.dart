import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';

class ImportAnchorData {
  const ImportAnchorData({
    required this.label,
    required this.lat,
    required this.lon,
    required this.ellipH,
    this.orthoH,
    this.accuracyH,
    this.source = 'manual',
    this.isFixed = true,
  });

  final String label;
  final double lat;
  final double lon;
  final double ellipH;
  final double? orthoH;
  final double? accuracyH;
  final String source;
  final bool isFixed;
}

class ImportSessionData {
  const ImportSessionData({
    required this.sessionCode,
    required this.sessionMode,
    required this.anchors,
    this.projectName,
  });

  final String sessionCode;
  final String sessionMode;
  final List<ImportAnchorData> anchors;
  final String? projectName;
}

class ExportService {
  Future<File> exportCsv({
    required Project project,
    required List<SurveyPoint> points,
  }) async {
    final rows = <List<Object?>>[
      [
        'code',
        'layer',
        'description',
        'latitude',
        'longitude',
        'orthometric_height_m',
        'accuracy_h_m',
        'accuracy_v_m',
        'method',
        'quality',
        'pole_height_m',
        'captured_at',
      ],
      for (final point in points)
        [
          point.code,
          point.layer,
          point.description ?? '',
          point.lat.toStringAsFixed(7),
          point.lon.toStringAsFixed(7),
          point.orthoH.toStringAsFixed(3),
          point.accuracyH.toStringAsFixed(2),
          point.accuracyV?.toStringAsFixed(2) ?? '',
          point.method,
          point.quality,
          point.poleHeight.toStringAsFixed(2),
          point.createdAt.toUtc().toIso8601String(),
        ],
    ];

    final content = Csv(addBom: true).encode(rows);
    return _writeFile(project: project, extension: 'csv', content: content);
  }

  Future<File> exportGeoJson({
    required Project project,
    required List<SurveyPoint> points,
  }) async {
    final data = <String, dynamic>{
      'type': 'FeatureCollection',
      'name': project.name,
      'features': [
        for (final point in points)
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [point.lon, point.lat, point.orthoH],
            },
            'properties': {
              'code': point.code,
              'layer': point.layer,
              'description': point.description,
              'accuracy_h_m': point.accuracyH,
              'accuracy_v_m': point.accuracyV,
              'method': point.method,
              'quality': point.quality,
              'pole_height_m': point.poleHeight,
              'captured_at': point.createdAt.toUtc().toIso8601String(),
            },
          },
      ],
    };

    return _writeFile(
      project: project,
      extension: 'geojson',
      content: const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<void> shareFile(File file, {String? subject}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: subject,
        text: subject == null ? null : 'Data survey TopoSurvey: $subject',
      ),
    );
  }

  String generateSessionJson({
    required Project project,
    required Session session,
    required List<Anchor> anchors,
    required List<SurveyPoint> points,
  }) {
    final payload = <String, dynamic>{
      'app': 'TopoSurvey',
      'version': 1,
      'exported_at': DateTime.now().toUtc().toIso8601String(),
      'project': {
        'id': project.id,
        'name': project.name,
        'originLat': project.originLat,
        'originLon': project.originLon,
        'benchmarkHeight': project.benchmarkHeight,
        'basePressureHpa': project.basePressureHpa,
      },
      'session': {
        'id': session.id,
        'code': session.code,
        'mode': session.mode,
        'started_at': session.startedAt.toUtc().toIso8601String(),
      },
      'anchors': [
        for (final a in anchors)
          {
            'id': a.id,
            'label': a.label,
            'lat': a.lat,
            'lon': a.lon,
            'ellipH': a.ellipH,
            'orthoH': a.orthoH,
            'accuracyH': a.accuracyH,
            'source': a.source,
            'isFixed': a.isFixed,
          },
      ],
      'points': [
        for (final p in points)
          {
            'id': p.id,
            'code': p.code,
            'layer': p.layer,
            'lat': p.lat,
            'lon': p.lon,
            'orthoH': p.orthoH,
            'accuracyH': p.accuracyH,
            'method': p.method,
            'quality': p.quality,
            'poleHeight': p.poleHeight,
          },
      ],
    };

    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  Future<File> exportSessionJson({
    required Project project,
    required Session session,
    required List<Anchor> anchors,
    required List<SurveyPoint> points,
  }) async {
    final content = generateSessionJson(
      project: project,
      session: session,
      anchors: anchors,
      points: points,
    );
    return _writeFile(project: project, extension: 'json', content: content);
  }

  ImportSessionData? parseSessionJson(String jsonString) {
    try {
      final map = jsonDecode(jsonString);
      if (map is! Map<String, dynamic>) return null;
      if (map['app'] != 'TopoSurvey') return null;

      final sessionMap = map['session'] as Map<String, dynamic>?;
      if (sessionMap == null) return null;

      final sessionCode = sessionMap['code'] as String? ?? '';
      final sessionMode = sessionMap['mode'] as String? ?? '';
      final projectMap = map['project'] as Map<String, dynamic>?;
      final projectName = projectMap?['name'] as String?;

      final rawAnchors = map['anchors'] as List<dynamic>? ?? const [];
      final anchors = <ImportAnchorData>[];
      for (final a in rawAnchors) {
        if (a is Map<String, dynamic>) {
          anchors.add(
            ImportAnchorData(
              label: a['label'] as String? ?? 'Anchor',
              lat: (a['lat'] as num).toDouble(),
              lon: (a['lon'] as num).toDouble(),
              ellipH: (a['ellipH'] as num).toDouble(),
              orthoH: (a['orthoH'] as num?)?.toDouble(),
              accuracyH: (a['accuracyH'] as num?)?.toDouble(),
              source: a['source'] as String? ?? 'manual',
              isFixed: a['isFixed'] as bool? ?? true,
            ),
          );
        }
      }

      return ImportSessionData(
        sessionCode: sessionCode,
        sessionMode: sessionMode,
        anchors: anchors,
        projectName: projectName,
      );
    } catch (_) {
      return null;
    }
  }

  Future<File> _writeFile({
    required Project project,
    required String extension,
    required String content,
  }) async {
    final baseDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(baseDirectory.path, 'exports'));
    await directory.create(recursive: true);

    final safeName = Formatters.fileName(project.name);
    final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'[:.]'),
      '-',
    );
    final file = File(
      p.join(directory.path, 'toposurvey_${safeName}_$stamp.$extension'),
    );
    await file.writeAsString(content);
    return file;
  }
}
