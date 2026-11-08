import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/utils/formatters.dart';
import '../../providers/app_providers.dart';
import '../common/quality_badge.dart';

class SensorCheckScreen extends ConsumerStatefulWidget {
  const SensorCheckScreen({super.key});

  @override
  ConsumerState<SensorCheckScreen> createState() => _SensorCheckScreenState();
}

class _SensorCheckScreenState extends ConsumerState<SensorCheckScreen> {
  static const _permissions = [
    Permission.locationWhenInUse,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.bluetoothAdvertise,
  ];

  Map<Permission, PermissionStatus>? _statuses;
  bool? _locationServiceEnabled;

  @override
  void initState() {
    super.initState();
    _refreshPermissions();
  }

  Future<void> _refreshPermissions() async {
    final statuses = await _permissions.request();
    final serviceEnabled = await ref
        .read(gnssServiceProvider)
        .isLocationServiceEnabled();
    if (!mounted) return;
    setState(() {
      _statuses = statuses;
      _locationServiceEnabled = serviceEnabled;
    });
    ref.invalidate(livePositionProvider);
  }

  IconData _permissionIcon(PermissionStatus? status) {
    if (status == PermissionStatus.granted) return Icons.check_circle;
    if (status == PermissionStatus.denied) return Icons.cancel_outlined;
    return Icons.help_outline;
  }

  Color _permissionColor(BuildContext context, PermissionStatus? status) {
    if (status == PermissionStatus.granted) {
      return qualityColor(context, 'good');
    }
    if (status == PermissionStatus.permanentlyDenied) {
      return Theme.of(context).colorScheme.error;
    }
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  String _permissionStatusLabel(PermissionStatus? status) {
    return switch (status) {
      PermissionStatus.granted => 'Diizinkan',
      PermissionStatus.denied => 'Belum diizinkan',
      PermissionStatus.permanentlyDenied => 'Ditolak permanen',
      PermissionStatus.restricted => 'Dibatasi',
      PermissionStatus.limited => 'Terbatas',
      PermissionStatus.provisional => 'Sementara',
      _ => 'Belum dicek',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final livePosition = ref.watch(livePositionProvider);
    final barometer = ref.watch(barometerProvider);
    final locationStatus = _statuses?[Permission.locationWhenInUse];
    final scanStatus = _statuses?[Permission.bluetoothScan];
    final advertiseStatus = _statuses?[Permission.bluetoothAdvertise];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Sensor'),
        actions: [
          IconButton(
            tooltip: 'Minta izin',
            onPressed: _refreshPermissions,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status izin', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  _PermissionRow(
                    icon: _permissionIcon(locationStatus),
                    color: _permissionColor(context, locationStatus),
                    label: 'Lokasi presisi',
                    status: _permissionStatusLabel(locationStatus),
                  ),
                  _PermissionRow(
                    icon: _permissionIcon(scanStatus),
                    color: _permissionColor(context, scanStatus),
                    label: 'BLE scan',
                    status: _permissionStatusLabel(scanStatus),
                  ),
                  _PermissionRow(
                    icon: _permissionIcon(advertiseStatus),
                    color: _permissionColor(context, advertiseStatus),
                    label: 'BLE advertise',
                    status: _permissionStatusLabel(advertiseStatus),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _locationServiceEnabled == null
                        ? 'Status layanan lokasi belum dicek.'
                        : _locationServiceEnabled!
                        ? 'Layanan lokasi Android aktif.'
                        : 'Layanan lokasi Android nonaktif. Aktifkan GPS.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: _refreshPermissions,
                    icon: const Icon(Icons.security),
                    label: const Text('Minta Izin'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.gps_fixed, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('GNSS', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  livePosition.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (error, stackTrace) => Text(
                      'GNSS belum aktif. Periksa izin lokasi dan GPS.\n$error',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                    data: (position) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          label: 'Latitude',
                          value: Formatters.latitude(position.latitude),
                        ),
                        InfoRow(
                          label: 'Longitude',
                          value: Formatters.longitude(position.longitude),
                        ),
                        InfoRow(
                          label: 'Akurasi horizontal',
                          value: Formatters.meters(position.accuracy),
                        ),
                        InfoRow(
                          label: 'Altitude',
                          value: position.hasAltitude
                              ? Formatters.meters(position.altitude)
                              : 'Tidak tersedia',
                        ),
                        InfoRow(
                          label: 'Akurasi vertikal',
                          value: position.hasAltitudeAccuracy
                              ? Formatters.meters(position.altitudeAccuracy)
                              : 'Tidak tersedia',
                        ),
                        InfoRow(
                          label: 'Waktu',
                          value: Formatters.dateTime(position.timestamp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.speed, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('Barometer', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  barometer.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (error, stackTrace) => Text(
                      'Sensor barometer tidak tersedia pada HP ini. '
                      'Aplikasi akan memakai altitude GNSS.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    data: (reading) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          label: 'Tekanan',
                          value: Formatters.pressure(reading.pressureHpa),
                        ),
                        InfoRow(
                          label: 'Waktu',
                          value: Formatters.dateTime(reading.timestamp),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Barometer membantu beda tinggi relatif. '
                          'Kalibrasi base diperlukan untuk tinggi absolut.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bluetooth_searching,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text('BLE Ranging', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Izin BLE sudah disiapkan. Scan/advertise dan estimasi jarak '
                    'akan aktif pada pengembangan tahap BLE ranging.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.status,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          Text(
            status,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
