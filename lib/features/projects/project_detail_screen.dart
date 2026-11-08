import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/labels.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import '../common/quality_badge.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  Future<void> _startSurvey(
    BuildContext context,
    WidgetRef ref,
    Project project,
  ) async {
    var selectedMode = SessionMode.single;
    var selectedRole = DeviceRole.rover;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Setup Sesi Survey'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih Mode Pengukuran:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    RadioGroup<String>(
                      groupValue: selectedMode,
                      onChanged: (v) {
                        if (v != null) setState(() => selectedMode = v);
                      },
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Single Device (1 HP)'),
                            subtitle: const Text('GNSS averaging + barometer'),
                            value: SessionMode.single,
                          ),
                          RadioListTile<String>(
                            title: const Text('Virtual Anchor (2 HP)'),
                            subtitle: const Text('Trilaterasi dengan anchor diketahui'),
                            value: SessionMode.virtualAnchor,
                          ),
                          RadioListTile<String>(
                            title: const Text('Network (3 HP)'),
                            subtitle: const Text('Joint network adjustment 3 perangkat'),
                            value: SessionMode.network,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 24),
                    const Text('Peran Perangkat Ini:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRole,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(value: DeviceRole.rover, child: Text('Rover (Pengukur Titik)')),
                        DropdownMenuItem(value: DeviceRole.anchor, child: Text('Anchor (Titik Acuan)')),
                        DropdownMenuItem(value: DeviceRole.base, child: Text('Base (Stasiun Tetap)')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => selectedRole = v);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Batal'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Mulai'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed != true) return;

    final session = await ref.read(surveyRepositoryProvider).startSession(
          project.id,
          mode: selectedMode,
          role: selectedRole,
        );
    if (!context.mounted) return;
    context.push('/project/${project.id}/survey?session=${session.id}');
  }

  Future<void> _calibrateBase(
    BuildContext context,
    WidgetRef ref,
    Project project,
  ) async {
    final pressure = ref.read(barometerProvider).value?.pressureHpa;
    if (pressure == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Barometer belum membaca. Cek sensor atau tunggu beberapa detik.',
          ),
        ),
      );
      return;
    }

    final benchmarkController = TextEditingController(
      text: project.benchmarkHeight?.toStringAsFixed(2) ?? '',
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kalibrasi Base'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tekanan base saat ini: ${Formatters.pressure(pressure)}'),
              const SizedBox(height: 12),
              TextField(
                controller: benchmarkController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Tinggi benchmark/base (m, opsional)',
                  helperText: 'Kosongkan untuk datum lokal',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    final benchmarkText = benchmarkController.text.trim();
    benchmarkController.dispose();
    if (saved != true) return;

    double? benchmark;
    if (benchmarkText.isNotEmpty) {
      benchmark = double.tryParse(benchmarkText.replaceAll(',', '.'));
      if (benchmark == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tinggi benchmark tidak valid.')),
          );
        }
        return;
      }
    }

    await ref
        .read(projectRepositoryProvider)
        .updateCalibration(
          projectId: project.id,
          benchmarkHeight: benchmark,
          basePressureHpa: pressure,
        );
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kalibrasi base disimpan.')));
  }

  Future<void> _export(
    BuildContext context,
    WidgetRef ref,
    Project project,
    String format,
  ) async {
    final points = await ref
        .read(surveyRepositoryProvider)
        .getPoints(project.id);
    if (points.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum ada titik untuk diekspor.')),
        );
      }
      return;
    }

    try {
      final exporter = ref.read(exportServiceProvider);
      final file = format == 'csv'
          ? await exporter.exportCsv(project: project, points: points)
          : await exporter.exportGeoJson(project: project, points: points);
      await exporter.shareFile(file, subject: project.name);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File diekspor: ${file.path}')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengekspor: $error')));
    }
  }

  Future<void> _deletePoint(
    BuildContext context,
    WidgetRef ref,
    SurveyPoint point,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus titik?'),
        content: Text('Titik ${point.code} akan dihapus dari proyek.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(surveyRepositoryProvider).deletePoint(point.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Titik ${point.code} dihapus.')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));
    final pointsAsync = ref.watch(pointsStreamProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Proyek'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Ekspor',
            onSelected: (value) {
              final project = projectAsync.value;
              if (project != null) {
                _export(context, ref, project, value);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'csv', child: Text('Ekspor CSV')),
              PopupMenuItem(value: 'geojson', child: Text('Ekspor GeoJSON')),
            ],
          ),
        ],
      ),
      body: projectAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Gagal memuat proyek: $error'),
          ),
        ),
        data: (project) {
          if (project == null) {
            return const Center(child: Text('Proyek tidak ditemukan.'));
          }
          final points = pointsAsync.value ?? const <SurveyPoint>[];
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (project.description?.isNotEmpty == true) ...[
                        const SizedBox(height: 4),
                        Text(
                          project.description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                      const SizedBox(height: 12),
                      InfoRow(
                        label: 'Datum',
                        value: project.benchmarkHeight == null
                            ? 'Lokal / GNSS'
                            : 'Benchmark ${Formatters.meters(project.benchmarkHeight, decimals: 2)}',
                      ),
                      InfoRow(
                        label: 'Origin',
                        value:
                            project.originLat == null ||
                                project.originLon == null
                            ? 'Mengikuti titik pertama'
                            : '${Formatters.latitude(project.originLat!)}, '
                                  '${Formatters.longitude(project.originLon!)}',
                      ),
                      InfoRow(
                        label: 'Tekanan base',
                        value: Formatters.pressure(project.basePressureHpa),
                      ),
                      InfoRow(
                        label: 'Dibuat',
                        value: Formatters.dateTime(project.createdAt),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _startSurvey(context, ref, project),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Mulai Survey'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _calibrateBase(context, ref, project),
                icon: const Icon(Icons.speed),
                label: const Text('Kalibrasi Base / Barometer'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Titik Survey (${points.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    'Mode single',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (points.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.landscape_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Belum ada titik. Mulai survey untuk mengambil '
                          'titik pertama.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                for (final point in points)
                  Card(
                    child: ListTile(
                      leading: QualityBadge(
                        quality: point.quality,
                        compact: true,
                      ),
                      title: Text(point.code),
                      subtitle: Text(
                        '${point.layer} • ${methodLabel(point.method)} • '
                        '${Formatters.meters(point.orthoH, decimals: 2)}',
                      ),
                      trailing: PopupMenuButton<String>(
                        tooltip: 'Menu titik',
                        onSelected: (value) {
                          if (value == 'delete') {
                            _deletePoint(context, ref, point);
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Hapus titik'),
                          ),
                        ],
                      ),
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(point.code),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(
                                label: 'Latitude',
                                value: Formatters.latitude(point.lat),
                              ),
                              InfoRow(
                                label: 'Longitude',
                                value: Formatters.longitude(point.lon),
                              ),
                              InfoRow(
                                label: 'Tinggi',
                                value: Formatters.meters(
                                  point.orthoH,
                                  decimals: 2,
                                ),
                              ),
                              InfoRow(
                                label: 'Akurasi H',
                                value: Formatters.meters(point.accuracyH),
                              ),
                              InfoRow(
                                label: 'Metode',
                                value: methodLabel(point.method),
                              ),
                              InfoRow(
                                label: 'Kualitas',
                                value: qualityLabel(point.quality),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tutup'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
