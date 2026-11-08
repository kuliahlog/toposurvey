import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/utils/formatters.dart';
import '../../core/utils/labels.dart';
import '../../data/database/app_database.dart';
import '../../domain/services/barometer_service.dart';
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
    final pointsAsync = ref.watch(pointsStreamProvider(widget.projectId));
    final positionAsync = ref.watch(livePositionProvider);
    final baroAsync = ref.watch(barometerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
        actions: [
          IconButton(
            tooltip: 'Restart GNSS',
            onPressed: () {
              ref.invalidate(livePositionProvider);
              _ensureLocation();
            },
            icon: const Icon(Icons.my_location),
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
              label: const Text('Catat Titik'),
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
