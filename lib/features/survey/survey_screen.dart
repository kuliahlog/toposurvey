import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/constants/app_constants.dart';
import '../../core/geo/geodesy.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/labels.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/point_draft.dart';
import '../../domain/services/barometer_service.dart';
import '../../domain/services/solver_service.dart';
import '../../providers/app_providers.dart';
import '../common/quality_badge.dart';
import 'capture_sheet.dart';
import 'local_map.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  const SurveyScreen({
    super.key,
    required this.projectId,
    required this.sessionId,
  });

  final String projectId;
  final String sessionId;

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  bool? _permissionReady;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureLocation());
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _ensureLocation() async {
    final granted = await ref.read(gnssServiceProvider).ensurePermission();
    if (!mounted) return;
    setState(() => _permissionReady = granted);
    if (granted) {
      ref.invalidate(livePositionProvider);
    }
  }

  Future<void> _capturePoint(Project project, List<SurveyPoint> points) async {
    if (_permissionReady != true) {
      await _ensureLocation();
      if (!mounted) return;
      if (_permissionReady != true) return;
    }

    final point = await showCaptureSheet(
      context: context,
      project: project,
      sessionId: widget.sessionId,
      suggestedCode: 'TP-${(points.length + 1).toString().padLeft(3, '0')}',
    );

    if (point != null && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Titik ${point.code} disimpan.')));
    }
  }

  Future<void> _deletePoint(SurveyPoint point) async {
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
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Titik ${point.code} dihapus.')));
  }

  Future<void> _addAnchor(
    Project project,
    List<Anchor> anchors,
    Position? livePosition,
  ) async {
    final labelCtrl = TextEditingController(text: 'A${anchors.length + 1}');
    final latCtrl = TextEditingController(
      text: livePosition != null
          ? livePosition.latitude.toStringAsFixed(7)
          : (project.originLat?.toStringAsFixed(7) ?? ''),
    );
    final lonCtrl = TextEditingController(
      text: livePosition != null
          ? livePosition.longitude.toStringAsFixed(7)
          : (project.originLon?.toStringAsFixed(7) ?? ''),
    );
    final altCtrl = TextEditingController(
      text: livePosition != null
          ? livePosition.altitude.toStringAsFixed(2)
          : (project.originEllipH?.toStringAsFixed(2) ?? '0.0'),
    );

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Titik Anchor'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelCtrl,
                decoration: const InputDecoration(labelText: 'Label Anchor (misal A1, A2)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: latCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: lonCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: altCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(labelText: 'Tinggi Elipsoid / Z (m)'),
              ),
              if (livePosition != null) ...[
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    latCtrl.text = livePosition.latitude.toStringAsFixed(7);
                    lonCtrl.text = livePosition.longitude.toStringAsFixed(7);
                    altCtrl.text = livePosition.altitude.toStringAsFixed(2);
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text('Gunakan GPS Live Saat Ini'),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Simpan')),
        ],
      ),
    );

    if (saved != true) return;
    final lat = double.tryParse(latCtrl.text.replaceAll(',', '.'));
    final lon = double.tryParse(lonCtrl.text.replaceAll(',', '.'));
    final alt = double.tryParse(altCtrl.text.replaceAll(',', '.')) ?? 0.0;
    final label = labelCtrl.text.trim();

    if (lat == null || lon == null || label.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Koordinat tidak valid.')));
      }
      return;
    }

    await ref.read(surveyRepositoryProvider).addAnchor(
          sessionId: widget.sessionId,
          label: label,
          lat: lat,
          lon: lon,
          ellipH: alt,
          orthoH: alt,
          accuracyH: livePosition?.accuracy,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anchor $label tersimpan.')));
    }
  }

  Future<void> _deleteAnchor(Anchor anchor) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus anchor?'),
        content: Text('Anchor ${anchor.label} akan dihapus dari sesi ini.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(surveyRepositoryProvider).deleteAnchor(anchor.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anchor ${anchor.label} dihapus.')));
    }
  }

  Future<void> _calculateTrilateration(
    Project project,
    List<Anchor> anchors,
    List<SurveyPoint> points,
    Position? livePosition,
  ) async {
    if (anchors.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dibutuhkan minimal 3 anchor untuk menghitung trilaterasi.'),
        ),
      );
      return;
    }

    final distanceControllers = <String, TextEditingController>{
      for (final a in anchors) a.id: TextEditingController(),
    };
    final codeCtrl = TextEditingController(
      text: 'TR-${(points.length + 1).toString().padLeft(3, '0')}',
    );
    final poleCtrl = TextEditingController(text: '1.5');

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hitung Posisi Rover (Trilaterasi)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: 'Kode Titik Target'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: poleCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Tinggi Tongkat (m)'),
              ),
              const Divider(height: 24),
              const Text(
                'Masukkan Jarak ke Masing-Masing Anchor:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (final a in anchors)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: distanceControllers[a.id],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Jarak ke ${a.label} (meter)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.calculate),
            label: const Text('Hitung & Simpan'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final obsList = <GeoAnchorObservation>[];
    for (final a in anchors) {
      final text = distanceControllers[a.id]!.text.trim().replaceAll(',', '.');
      final dist = double.tryParse(text);
      if (dist == null || dist <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Jarak ke anchor ${a.label} tidak valid.')),
          );
        }
        return;
      }
      obsList.add(
        GeoAnchorObservation(
          position: GeoPoint(latitude: a.lat, longitude: a.lon, height: a.ellipH),
          distance: dist,
          sigma: 0.5,
          anchorId: a.id,
        ),
      );
    }

    final poleHeight = double.tryParse(poleCtrl.text.replaceAll(',', '.')) ?? 1.5;
    final origin = GeoPoint(
      latitude: project.originLat ?? anchors.first.lat,
      longitude: project.originLon ?? anchors.first.lon,
      height: project.originEllipH ?? anchors.first.ellipH,
    );

    GeoPoint? gnssPrior;
    double? gnssSigma;
    if (livePosition != null) {
      gnssPrior = GeoPoint(
        latitude: livePosition.latitude,
        longitude: livePosition.longitude,
        height: livePosition.altitude,
      );
      gnssSigma = livePosition.accuracy;
    }

    final result = ref.read(solverServiceProvider).solveTrilateration(
          origin: origin,
          anchors: obsList,
          gnssPrior: gnssPrior,
          gnssSigma: gnssSigma,
          poleHeight: poleHeight,
        );

    final draft = PointDraft(
      code: codeCtrl.text.trim().isEmpty ? 'TR-001' : codeCtrl.text.trim(),
      layer: 'tanah',
      latitude: result.estimatedGeo.latitude,
      longitude: result.estimatedGeo.longitude,
      orthometricHeight: result.estimatedGeo.height,
      ellipsoidHeight: result.estimatedGeo.height,
      accuracyH: result.solverResult.horizontalAccuracy,
      accuracyV: result.solverResult.rmsResidual,
      poleHeight: poleHeight,
      method: SurveyMethod.trilateration,
      quality: result.solverResult.quality,
      sampleCount: anchors.length,
      stdLat: result.solverResult.horizontalAccuracy / math.sqrt(2),
      stdLon: result.solverResult.horizontalAccuracy / math.sqrt(2),
      stdAlt: result.solverResult.rmsResidual,
      capturedAt: DateTime.now(),
      description: 'Trilaterasi ${anchors.length} anchor (RMS: ${result.solverResult.rmsResidual.toStringAsFixed(2)}m)',
    );

    await ref.read(surveyRepositoryProvider).addPoint(
          projectId: widget.projectId,
          sessionId: widget.sessionId,
          draft: draft,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Titik ${draft.code} disimpan (${result.solverResult.quality.toUpperCase()}, RMS ${result.solverResult.rmsResidual.toStringAsFixed(2)}m)',
          ),
        ),
      );
    }
  }

  Future<void> _exportSessionJson(
    Project project,
    Session session,
    List<Anchor> anchors,
    List<SurveyPoint> points,
  ) async {
    try {
      final exporter = ref.read(exportServiceProvider);
      final file = await exporter.exportSessionJson(
        project: project,
        session: session,
        anchors: anchors,
        points: points,
      );
      await exporter.shareFile(file, subject: 'Sesi ${session.code} - ${project.name}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengekspor sesi: $e')));
      }
    }
  }

  Future<void> _importAnchorJson() async {
    final ctrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Impor Anchor dari JSON'),
        content: TextField(
          controller: ctrl,
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: 'Tempel teks JSON dari sesi HP lain di sini...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Impor')),
        ],
      ),
    );

    if (confirmed != true) return;
    final jsonStr = ctrl.text.trim();
    final parsed = ref.read(exportServiceProvider).parseSessionJson(jsonStr);

    if (parsed == null || parsed.anchors.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Format JSON tidak valid atau tidak memiliki data anchor.')),
        );
      }
      return;
    }

    var count = 0;
    for (final a in parsed.anchors) {
      await ref.read(surveyRepositoryProvider).addAnchor(
            sessionId: widget.sessionId,
            label: a.label,
            lat: a.lat,
            lon: a.lon,
            ellipH: a.ellipH,
            orthoH: a.orthoH,
            accuracyH: a.accuracyH,
            source: 'import',
          );
      count++;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil mengimpor $count anchor dari HP lain.')),
      );
    }
  }

  void _showPointDetail(SurveyPoint point) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        point.code,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    QualityBadge(quality: point.quality),
                  ],
                ),
                const SizedBox(height: 12),
                InfoRow(label: 'Layer', value: point.layer),
                InfoRow(
                  label: 'Deskripsi',
                  value: point.description?.isNotEmpty == true
                      ? point.description!
                      : '-',
                ),
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
                  value: Formatters.meters(point.orthoH, decimals: 2),
                ),
                InfoRow(
                  label: 'Akurasi H',
                  value: Formatters.meters(point.accuracyH),
                ),
                InfoRow(
                  label: 'Akurasi V',
                  value: Formatters.meters(point.accuracyV),
                ),
                InfoRow(label: 'Metode', value: methodLabel(point.method)),
                InfoRow(
                  label: 'Tinggi tongkat',
                  value: Formatters.meters(point.poleHeight, decimals: 2),
                ),
                InfoRow(
                  label: 'Waktu',
                  value: Formatters.dateTime(point.createdAt),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectAsync = ref.watch(projectProvider(widget.projectId));
    final sessionAsync = ref.watch(sessionProvider(widget.sessionId));
    final anchorsAsync = ref.watch(anchorsStreamProvider(widget.sessionId));
    final pointsAsync = ref.watch(pointsStreamProvider(widget.projectId));
    final positionAsync = ref.watch(livePositionProvider);
    final baroAsync = ref.watch(barometerProvider);

    final session = sessionAsync.value;
    final anchors = anchorsAsync.value ?? const <Anchor>[];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Survey'),
            if (session != null)
              Text(
                '${sessionModeLabel(session.mode)} • ${session.code}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Restart GNSS',
            onPressed: () {
              ref.invalidate(livePositionProvider);
              _ensureLocation();
            },
            icon: const Icon(Icons.my_location),
          ),
          PopupMenuButton<String>(
            tooltip: 'Menu Sesi',
            onSelected: (value) {
              final project = projectAsync.value;
              if (project == null || session == null) return;
              if (value == 'export_json') {
                _exportSessionJson(
                  project,
                  session,
                  anchors,
                  pointsAsync.value ?? const [],
                );
              } else if (value == 'import_json') {
                _importAnchorJson();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'export_json',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Ekspor Sesi JSON'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'import_json',
                child: ListTile(
                  leading: Icon(Icons.file_download),
                  title: Text('Impor Anchor JSON'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: projectAsync.value == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _capturePoint(
                projectAsync.value!,
                pointsAsync.value ?? const [],
              ),
              icon: const Icon(Icons.add_location_alt_outlined),
              label: const Text('Catat Titik (GNSS)'),
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
          final position = positionAsync.value;
          final pressure = baroAsync.value?.pressureHpa;
          final relativeHeight =
              pressure != null && project.basePressureHpa != null
              ? BarometerService.relativeHeightMeters(
                  pressureHpa: pressure,
                  basePressureHpa: project.basePressureHpa!,
                )
              : null;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              if (_permissionReady == false)
                _PermissionBanner(onRequest: _ensureLocation),
              LocalSurveyMap(
                project: project,
                points: points,
                anchors: anchors,
                livePosition: position,
              ),
              const SizedBox(height: 12),
              _LiveStatusCard(
                position: position,
                positionError: positionAsync.hasError,
                pressureHpa: pressure,
                barometerError: baroAsync.hasError,
                relativeHeight: relativeHeight,
              ),
              if (session != null && session.mode == SessionMode.virtualAnchor) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.anchor, color: Colors.amber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Anchor Virtual (${anchors.length})',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Catat minimal 3 anchor berjarak diketahui untuk menentukan posisi rover dengan trilaterasi.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _addAnchor(project, anchors, position),
                                icon: const Icon(Icons.add),
                                label: const Text('Tambah Anchor'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: anchors.length >= 3
                                    ? () => _calculateTrilateration(
                                          project,
                                          anchors,
                                          points,
                                          position,
                                        )
                                    : null,
                                icon: const Icon(Icons.calculate),
                                label: const Text('Trilaterasi'),
                              ),
                            ),
                          ],
                        ),
                        if (anchors.isNotEmpty) ...[
                          const Divider(height: 24),
                          for (final a in anchors)
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.amber,
                                child: Icon(Icons.flag, size: 14, color: Colors.black87),
                              ),
                              title: Text(a.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                '${Formatters.latitude(a.lat)}, ${Formatters.longitude(a.lon)} • '
                                '${Formatters.meters(a.ellipH, decimals: 1)}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18),
                                onPressed: () => _deleteAnchor(a),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Titik Survey (${points.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    'Sesi ${widget.sessionId.substring(0, 6).toUpperCase()}',
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
                          Icons.add_location_alt_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Belum ada titik. Tekan "Catat Titik" untuk '
                          'memulai averaging GNSS.',
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
                          if (value == 'delete') _deletePoint(point);
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Hapus titik'),
                          ),
                        ],
                      ),
                      onTap: () => _showPointDetail(point),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner({required this.onRequest});

  final Future<void> Function() onRequest;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.location_off_outlined),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Izin lokasi/GPS belum aktif. Survey membutuhkan lokasi presisi.',
              ),
            ),
            TextButton(
              onPressed: () => onRequest(),
              child: const Text('Izinkan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveStatusCard extends StatelessWidget {
  const _LiveStatusCard({
    required this.position,
    required this.positionError,
    required this.pressureHpa,
    required this.barometerError,
    required this.relativeHeight,
  });

  final Position? position;
  final bool positionError;
  final double? pressureHpa;
  final bool barometerError;
  final double? relativeHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gnssValue = positionError
        ? 'Izin/lokasi tidak aktif'
        : position == null
        ? 'Menunggu fix'
        : '± ${Formatters.meters(position!.accuracy)}';
    final altitude = position == null || !position!.hasAltitude
        ? '-'
        : Formatters.meters(position!.altitude);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status sensor', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _StatusValue(
                    label: 'GNSS',
                    value: gnssValue,
                    icon: Icons.gps_fixed,
                  ),
                ),
                Expanded(
                  child: _StatusValue(
                    label: 'Altitude',
                    value: altitude,
                    icon: Icons.height,
                  ),
                ),
                Expanded(
                  child: _StatusValue(
                    label: 'Barometer',
                    value: barometerError
                        ? 'Tidak ada'
                        : Formatters.pressure(pressureHpa),
                    icon: Icons.speed,
                  ),
                ),
              ],
            ),
            if (relativeHeight != null) ...[
              const SizedBox(height: 8),
              Text(
                'Beda tinggi terhadap base: '
                '${Formatters.meters(relativeHeight)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusValue extends StatelessWidget {
  const _StatusValue({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
