import 'dart:math' as math;

import '../../core/constants/app_constants.dart';

class GnssSample {
  const GnssSample({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracyH,
    required this.accuracyV,
    required this.timestamp,
    this.hasAltitude = true,
  });

  final double latitude;
  final double longitude;
  final double altitude;
  final double accuracyH;
  final double accuracyV;
  final DateTime timestamp;
  final bool hasAltitude;
}

class AveragingResult {
  const AveragingResult({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracyH,
    required this.accuracyV,
    required this.sampleCount,
    required this.stdLat,
    required this.stdLon,
    required this.stdAlt,
    required this.startedAt,
    required this.endedAt,
    required this.quality,
    required this.hasAltitude,
  });

  final double latitude;
  final double longitude;
  final double altitude;
  final double accuracyH;
  final double accuracyV;
  final int sampleCount;
  final double stdLat;
  final double stdLon;
  final double stdAlt;
  final DateTime startedAt;
  final DateTime endedAt;
  final String quality;
  final bool hasAltitude;

  double get horizontalStd => math.sqrt(stdLat * stdLat + stdLon * stdLon);

  Duration get duration => endedAt.difference(startedAt);
}

class GnssAverager {
  final List<GnssSample> _samples = [];
  DateTime? _startedAt;

  int get sampleCount => _samples.length;

  DateTime? get startedAt => _startedAt;

  void reset() {
    _samples.clear();
    _startedAt = null;
  }

  void add(GnssSample sample) {
    if (!sample.latitude.isFinite || !sample.longitude.isFinite) return;
    if (!sample.accuracyH.isFinite || sample.accuracyH <= 0) return;
    if (sample.accuracyH > AppConstants.maxGnssAccuracyMeters) return;

    _startedAt ??= sample.timestamp;
    _samples.add(sample);
  }

  AveragingResult? summarize() {
    if (_samples.isEmpty) return null;

    final valid = _samples
        .where(
          (sample) =>
              sample.latitude.isFinite &&
              sample.longitude.isFinite &&
              sample.altitude.isFinite,
        )
        .toList();
    if (valid.isEmpty) return null;

    final filtered = _rejectOutliers(valid);
    final used = filtered.length >= 3 ? filtered : valid;

    final meanLat = _mean(used.map((s) => s.latitude));
    final meanLon = _mean(used.map((s) => s.longitude));
    final altitudeSamples = used.where((s) => s.hasAltitude).toList();
    final hasAltitude = altitudeSamples.isNotEmpty;
    final meanAlt = hasAltitude
        ? _mean(altitudeSamples.map((s) => s.altitude))
        : 0.0;

    final metersPerDegLat = 111320.0;
    final metersPerDegLon = 111320.0 * math.cos(meanLat * math.pi / 180).abs();

    final stdLat = _std(
      used.map((s) => (s.latitude - meanLat) * metersPerDegLat),
    );
    final stdLon = _std(
      used.map((s) => (s.longitude - meanLon) * metersPerDegLon),
    );
    final stdAlt = hasAltitude
        ? _std(altitudeSamples.map((s) => s.altitude - meanAlt))
        : 0.0;

    final reportedAccuracy = _mean(used.map((s) => s.accuracyH));
    final horizontalStd = math.sqrt(stdLat * stdLat + stdLon * stdLon);
    final accuracyH = math.max(reportedAccuracy, horizontalStd);

    final altitudeAccuracies = used
        .where((s) => s.hasAltitude && s.accuracyV > 0)
        .map((s) => s.accuracyV)
        .toList();
    final reportedAccuracyV = altitudeAccuracies.isEmpty
        ? 0.0
        : _mean(altitudeAccuracies);
    final accuracyV = math.max(reportedAccuracyV, stdAlt);

    return AveragingResult(
      latitude: meanLat,
      longitude: meanLon,
      altitude: meanAlt,
      accuracyH: accuracyH,
      accuracyV: accuracyV,
      sampleCount: used.length,
      stdLat: stdLat,
      stdLon: stdLon,
      stdAlt: stdAlt,
      startedAt: used.first.timestamp,
      endedAt: used.last.timestamp,
      quality: _quality(
        sampleCount: used.length,
        accuracyH: accuracyH,
        horizontalStd: horizontalStd,
        hasAltitude: hasAltitude,
      ),
      hasAltitude: hasAltitude,
    );
  }

  List<GnssSample> _rejectOutliers(List<GnssSample> input) {
    if (input.length < 5) return input;

    final meanLat = _mean(input.map((s) => s.latitude));
    final meanLon = _mean(input.map((s) => s.longitude));
    final metersPerDegLat = 111320.0;
    final metersPerDegLon = 111320.0 * math.cos(meanLat * math.pi / 180).abs();

    final residuals = input
        .map(
          (s) => math.sqrt(
            math.pow((s.latitude - meanLat) * metersPerDegLat, 2) +
                math.pow((s.longitude - meanLon) * metersPerDegLon, 2),
          ),
        )
        .toList();
    final rms = math.sqrt(
      residuals.fold<double>(0, (sum, value) => sum + value * value) /
          residuals.length,
    );
    final threshold = math.max(rms * 2.5, 2.0);

    return [
      for (var i = 0; i < input.length; i++)
        if (residuals[i] <= threshold) input[i],
    ];
  }

  double _mean(Iterable<double> values) {
    var sum = 0.0;
    var count = 0;
    for (final value in values) {
      sum += value;
      count++;
    }
    return count == 0 ? 0 : sum / count;
  }

  double _std(Iterable<double> values) {
    final list = values.toList();
    if (list.length < 2) return 0;
    final mean = _mean(list);
    final variance =
        list.fold<double>(
          0,
          (sum, value) => sum + math.pow(value - mean, 2).toDouble(),
        ) /
        list.length;
    return math.sqrt(variance);
  }

  String _quality({
    required int sampleCount,
    required double accuracyH,
    required double horizontalStd,
    required bool hasAltitude,
  }) {
    if (!hasAltitude) return QualityFlag.poor;
    if (sampleCount >= AppConstants.recommendedSamples &&
        accuracyH <= 8 &&
        horizontalStd <= 3) {
      return QualityFlag.good;
    }
    if (sampleCount >= AppConstants.minSamples && accuracyH <= 20) {
      return QualityFlag.fair;
    }
    return QualityFlag.poor;
  }
}
