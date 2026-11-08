import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';

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
