import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toposurvey/domain/services/gnss_service.dart';

class RecordingLocationPlatform extends GeolocatorPlatform {
  LocationSettings? settings;

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    settings = locationSettings;
    return const Stream.empty();
  }
}

void main() {
  test('requests updates fast enough to collect 30 samples in 60 seconds', () {
    final original = GeolocatorPlatform.instance;
    final platform = RecordingLocationPlatform();
    GeolocatorPlatform.instance = platform;
    addTearDown(() => GeolocatorPlatform.instance = original);

    GnssService().watchPosition();

    final settings = platform.settings;
    expect(settings, isA<AndroidSettings>());
    final interval = (settings as AndroidSettings).intervalDuration!;
    expect(interval.inMilliseconds, lessThanOrEqualTo(1000));
    expect(settings.distanceFilter, 0);
  });
}
