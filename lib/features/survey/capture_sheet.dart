import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/point_draft.dart';
import '../../domain/services/barometer_service.dart';
import '../../domain/services/gnss_averaging.dart';
import '../../providers/app_providers.dart';
import '../common/quality_badge.dart';

Future<SurveyPoint?> showCaptureSheet({
  required BuildContext context,
  required Project project,
  required String sessionId,
  required String suggestedCode,
}) {
  return showModalBottomSheet<SurveyPoint>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) => CaptureSheet(
      project: project,
      sessionId: sessionId,
      suggestedCode: suggestedCode,
    ),
  );
}

class CaptureSheet extends ConsumerStatefulWidget {
  const CaptureSheet({
    super.key,
    required this.project,
    required this.sessionId,
    required this.suggestedCode,
  });

  final Project project;
  final String sessionId;
  final String suggestedCode;

  @override
  ConsumerState<CaptureSheet> createState() => _CaptureSheetState();
}

class _CaptureSheetState extends ConsumerState<CaptureSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _layerController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _poleController;
  final _averager = GnssAverager();

  ProviderSubscription<AsyncValue<Position>>? _positionSubscription;
  ProviderSubscription<AsyncValue<BaroReading>>? _baroSubscription;

  Position? _lastPosition;
  double? _pressureHpa;
  double? _captureBasePressureHpa;
  AveragingResult? _result;
  Timer? _timer;
  DateTime? _lastSampleAt;
  bool _capturing = false;
  bool _saving = false;
  bool _barometerError = false;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.suggestedCode);
    _layerController = TextEditingController(text: 'tanah');
    _descriptionController = TextEditingController();
    _poleController = TextEditingController(
      text: AppConstants.defaultPoleHeightMeters.toStringAsFixed(1),
    );

    _positionSubscription = ref.listenManual(livePositionProvider, (
      previous,
      next,
    ) {
      final position = next.value;
      if (position != null) _handlePosition(position);
    }, fireImmediately: true);
    _baroSubscription = ref.listenManual(
      barometerProvider,
      (previous, next) {
        final reading = next.value;
        if (reading != null) _handleBarometer(reading);
      },
      onError: (error, stackTrace) {
        if (mounted) setState(() => _barometerError = true);
      },
      fireImmediately: true,
    );
    _lastPosition = ref.read(livePositionProvider).value;
    _pressureHpa = ref.read(barometerProvider).value?.pressureHpa;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _positionSubscription?.close();
    _baroSubscription?.close();
    _codeController.dispose();
    _layerController.dispose();
    _descriptionController.dispose();
    _poleController.dispose();
    super.dispose();
  }

  void _handlePosition(Position position) {
    if (!mounted) return;
    setState(() {
      _lastPosition = position;
      if (_capturing) {
        final now = DateTime.now();
        if (_lastSampleAt == null ||
            now.difference(_lastSampleAt!) >=
                const Duration(milliseconds: 900)) {
          _lastSampleAt = now;
          _averager.add(
            GnssSample(
              latitude: position.latitude,
              longitude: position.longitude,
              altitude: position.altitude,
              accuracyH: position.accuracy,
              accuracyV: position.altitudeAccuracy,
              timestamp: now,
              hasAltitude: position.hasAltitude,
            ),
          );
        }
      }
    });
  }

  void _handleBarometer(BaroReading reading) {
    if (!mounted) return;
    setState(() {
      _pressureHpa = reading.pressureHpa;
      _captureBasePressureHpa ??= reading.pressureHpa;
      _barometerError = false;
    });
  }

  void _startCapture() {
    if (_lastPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menunggu posisi GNSS pertama.')),
      );
      return;
    }

    _timer?.cancel();
    _averager.reset();
    _captureBasePressureHpa =
        widget.project.basePressureHpa ??
        _pressureHpa ??
        _captureBasePressureHpa;
    _result = null;
    _elapsedSeconds = 0;
    _lastSampleAt = null;
    _capturing = true;

    final position = _lastPosition!;
    _averager.add(
      GnssSample(
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude,
        accuracyH: position.accuracy,
        accuracyV: position.altitudeAccuracy,
        timestamp: DateTime.now(),
        hasAltitude: position.hasAltitude,
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _elapsedSeconds++);
      if (_elapsedSeconds >= AppConstants.captureDuration.inSeconds) {
        _stopCapture();
      }
    });

    setState(() {});
  }

  void _stopCapture() {
    _timer?.cancel();
    _timer = null;
    final result = _averager.summarize();
    setState(() {
      _capturing = false;
      _result = result;
    });
  }

  double? get _relativeBaroHeight {
    final basePressure = widget.project.basePressureHpa;
    final pressure = _pressureHpa;
    if (basePressure == null || pressure == null) return null;
    return BarometerService.relativeHeightMeters(
      pressureHpa: pressure,
      basePressureHpa: basePressure,
    );
  }

  String? get _heightWarning {
    final projectHasBenchmark =
        widget.project.benchmarkHeight != null &&
        widget.project.basePressureHpa != null &&
        _pressureHpa != null;
    if (projectHasBenchmark) return null;
    if (_result?.hasAltitude == true) return null;
    return 'HP tidak melaporkan altitude. Kalibrasi base + tinggi benchmark '
        'diperlukan sebelum titik dapat disimpan.';
  }

  Future<void> _save() async {
    final result = _result;
    if (result == null) return;
    if (!_formKey.currentState!.validate()) return;
    if (result.sampleCount < AppConstants.minSamples) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sampel belum cukup (${result.sampleCount}/'
            '${AppConstants.minSamples}). Ulangi sampling.',
          ),
        ),
      );
      return;
    }

    final poleHeight = double.tryParse(
      _poleController.text.trim().replaceAll(',', '.'),
    );
    if (poleHeight == null || poleHeight <= 0 || poleHeight > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tinggi tongkat harus antara 0 dan 5 m.')),
      );
      return;
    }

    final projectHasBenchmark =
        widget.project.benchmarkHeight != null &&
        widget.project.basePressureHpa != null &&
        _pressureHpa != null;

    late final double height;
    late final String method;
    double? relativeHeight;
    if (projectHasBenchmark) {
      relativeHeight = BarometerService.relativeHeightMeters(
        pressureHpa: _pressureHpa!,
        basePressureHpa: widget.project.basePressureHpa!,
      );
      height = widget.project.benchmarkHeight! + relativeHeight - poleHeight;
      method = SurveyMethod.gnssBaro;
    } else if (result.hasAltitude) {
      height = result.altitude - poleHeight;
      method = SurveyMethod.gnss;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_heightWarning ?? 'Tinggi tidak tersedia.')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final draft = PointDraft(
        code: _codeController.text.trim(),
        layer: _layerController.text.trim().isEmpty
            ? 'tanah'
            : _layerController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        latitude: result.latitude,
        longitude: result.longitude,
        orthometricHeight: height,
        ellipsoidHeight: result.hasAltitude ? result.altitude : null,
        accuracyH: result.accuracyH,
        accuracyV: result.accuracyV > 0 ? result.accuracyV : null,
        poleHeight: poleHeight,
        method: method,
        quality: result.quality,
        sampleCount: result.sampleCount,
        stdLat: result.stdLat,
        stdLon: result.stdLon,
        stdAlt: result.stdAlt,
        capturedAt: result.startedAt,
        pressureHpa: _pressureHpa,
        basePressureHpa:
            widget.project.basePressureHpa ?? _captureBasePressureHpa,
        relativeHeightM: relativeHeight,
      );

      final point = await ref
          .read(surveyRepositoryProvider)
          .addPoint(
            projectId: widget.project.id,
            sessionId: widget.sessionId,
            draft: draft,
          );
      if (!mounted) return;
      Navigator.of(context).pop(point);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan titik: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (_elapsedSeconds / AppConstants.captureDuration.inSeconds)
        .clamp(0.0, 1.0);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Catat Titik', style: theme.textTheme.headlineSmall),
              Text(
                'Averaging GNSS ${AppConstants.captureDuration.inSeconds} detik '
                '• minimal ${AppConstants.minSamples} sampel',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              _LiveMetrics(
                position: _lastPosition,
                sampleCount: _averager.sampleCount,
                pressureHpa: _pressureHpa,
                barometerError: _barometerError,
                relativeHeight: _relativeBaroHeight,
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _capturing
                        ? 'Merekam ${Formatters.seconds(_elapsedSeconds)} / '
                              '${Formatters.seconds(AppConstants.captureDuration.inSeconds)}'
                        : _result != null
                        ? 'Sampling selesai'
                        : 'Siap memulai sampling',
                    style: theme.textTheme.bodySmall,
                  ),
                  if (_result != null)
                    Text(
                      '${_result!.sampleCount} sampel',
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
              if (_result != null) ...[
                const SizedBox(height: 12),
                _ResultCard(result: _result!),
              ],
              if (_result != null &&
                  _result!.sampleCount < AppConstants.minSamples)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Sampel belum cukup. Ulangi sampling di area terbuka.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              if (_heightWarning != null && _result != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _heightWarning!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _codeController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Kode titik',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _layerController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Layer'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (opsional)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _poleController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Tinggi tongkat/HP di atas titik (m)',
                ),
                validator: (value) {
                  final parsed = double.tryParse(
                    (value ?? '').trim().replaceAll(',', '.'),
                  );
                  if (parsed == null || parsed <= 0 || parsed > 5) {
                    return 'Isi 0.1–5.0 m';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (!_capturing)
                FilledButton.icon(
                  onPressed: _saving ? null : _startCapture,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(
                    _result == null ? 'Mulai Sampling' : 'Ulangi Sampling',
                  ),
                )
              else
                FilledButton.icon(
                  onPressed: _stopCapture,
                  icon: const Icon(Icons.stop),
                  label: const Text('Hentikan Lebih Awal'),
                ),
              if (_result != null) ...[
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _saving || _heightWarning != null ? null : _save,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: const Text('Simpan Titik'),
                ),
              ],
              const SizedBox(height: 8),
              TextButton(
                onPressed: _saving ? null : () => Navigator.of(context).pop(),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveMetrics extends StatelessWidget {
  const _LiveMetrics({
    required this.position,
    required this.sampleCount,
    required this.pressureHpa,
    required this.barometerError,
    required this.relativeHeight,
  });

  final Position? position;
  final int sampleCount;
  final double? pressureHpa;
  final bool barometerError;
  final double? relativeHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Akurasi GNSS',
                  value: position == null
                      ? 'Menunggu'
                      : Formatters.meters(position!.accuracy),
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Altitude',
                  value: position == null || !position!.hasAltitude
                      ? 'Tidak ada'
                      : Formatters.meters(position!.altitude),
                ),
              ),
              Expanded(
                child: _Metric(label: 'Sampel', value: '$sampleCount'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Barometer',
                  value: barometerError
                      ? 'Tidak tersedia'
                      : Formatters.pressure(pressureHpa),
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Beda tinggi base',
                  value: relativeHeight == null
                      ? '-'
                      : Formatters.meters(relativeHeight),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final AveragingResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hasil rata-rata GNSS',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              QualityBadge(quality: result.quality, compact: true),
            ],
          ),
          const SizedBox(height: 8),
          InfoRow(
            label: 'Koordinat',
            value:
                '${Formatters.latitude(result.latitude)}, '
                '${Formatters.longitude(result.longitude)}',
          ),
          InfoRow(
            label: 'Std horizontal',
            value: Formatters.meters(result.horizontalStd),
          ),
          InfoRow(
            label: 'Std altitude',
            value: Formatters.meters(result.stdAlt),
          ),
          InfoRow(label: 'Durasi', value: '${result.duration.inSeconds} detik'),
          const InfoRow(label: 'Metode', value: 'Rata-rata GNSS'),
        ],
      ),
    );
  }
}
