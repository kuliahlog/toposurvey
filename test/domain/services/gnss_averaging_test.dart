import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/constants/app_constants.dart';
import 'package:toposurvey/domain/services/gnss_averaging.dart';

GnssSample sample({
  double latitude = -6.2,
  double longitude = 106.816666,
  double altitude = 100,
  double accuracyH = 3,
  double accuracyV = 5,
  bool hasAltitude = true,
  int seconds = 0,
}) {
  return GnssSample(
    latitude: latitude,
    longitude: longitude,
    altitude: altitude,
    accuracyH: accuracyH,
    accuracyV: accuracyV,
    hasAltitude: hasAltitude,
    timestamp: DateTime(2026, 11, 2, 8, 0, seconds),
  );
}

void main() {
  group('GnssAverager', () {
    test('returns null without samples', () {
      expect(GnssAverager().summarize(), isNull);
    });

    test('rejects invalid or inaccurate samples', () {
      final averager = GnssAverager()
        ..add(sample(latitude: double.nan))
        ..add(sample(accuracyH: 0))
        ..add(sample(accuracyH: AppConstants.maxGnssAccuracyMeters + 1))
        ..add(sample(accuracyH: -2));

      expect(averager.sampleCount, 0);
      expect(averager.summarize(), isNull);
    });

    test('averages position and altitude for a good fix', () {
      final averager = GnssAverager();
      for (var i = 0; i < AppConstants.recommendedSamples; i++) {
        averager.add(sample(seconds: i));
      }

      final result = averager.summarize()!;

      expect(result.latitude, closeTo(-6.2, 1e-12));
      expect(result.longitude, closeTo(106.816666, 1e-12));
      expect(result.altitude, closeTo(100, 1e-12));
      expect(result.sampleCount, AppConstants.recommendedSamples);
      expect(result.accuracyH, closeTo(3, 1e-12));
      expect(result.accuracyV, closeTo(5, 1e-12));
      expect(result.hasAltitude, isTrue);
      expect(result.quality, QualityFlag.good);
      expect(result.duration, const Duration(seconds: 29));
    });

    test('rejects a far outlier when enough samples exist', () {
      final averager = GnssAverager();
      for (var i = 0; i < 10; i++) {
        averager.add(sample(seconds: i));
      }
      averager.add(sample(latitude: -6.21, seconds: 10));

      final result = averager.summarize()!;

      expect(result.sampleCount, 10);
      expect(result.latitude, closeTo(-6.2, 1e-9));
      expect(result.stdLat, closeTo(0, 1e-6));
    });

    test('marks quality poor when altitude is unavailable', () {
      final averager = GnssAverager();
      for (var i = 0; i < AppConstants.recommendedSamples; i++) {
        averager.add(sample(seconds: i, hasAltitude: false));
      }

      final result = averager.summarize()!;

      expect(result.hasAltitude, isFalse);
      expect(result.altitude, 0);
      expect(result.accuracyV, 0);
      expect(result.quality, QualityFlag.poor);
    });

    test('assigns fair quality below the good threshold', () {
      final averager = GnssAverager();
      for (var i = 0; i < AppConstants.minSamples; i++) {
        averager.add(sample(seconds: i, accuracyH: 15));
      }

      final result = averager.summarize()!;

      expect(result.quality, QualityFlag.fair);
    });

    test('assigns poor quality for too few samples', () {
      final averager = GnssAverager();
      for (var i = 0; i < 10; i++) {
        averager.add(sample(seconds: i));
      }

      final result = averager.summarize()!;

      expect(result.quality, QualityFlag.poor);
    });

    test('reset clears accumulated samples', () {
      final averager = GnssAverager()..add(sample());

      averager.reset();

      expect(averager.sampleCount, 0);
      expect(averager.startedAt, isNull);
      expect(averager.summarize(), isNull);
    });
  });
}
