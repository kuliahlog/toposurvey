import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:toposurvey/core/geo/geodesy.dart';

void main() {
  group('Geodesy.toEcef', () {
    test('maps equator/prime meridian to WGS84 semi-major axis', () {
      final ecef = Geodesy.toEcef(
        const GeoPoint(latitude: 0, longitude: 0, height: 0),
      );

      expect(ecef.x, closeTo(Geodesy.wgs84A, 1e-6));
      expect(ecef.y, closeTo(0, 1e-6));
      expect(ecef.z, closeTo(0, 1e-6));
    });

    test('maps north pole to semi-minor axis', () {
      final ecef = Geodesy.toEcef(
        const GeoPoint(latitude: 90, longitude: 0, height: 0),
      );
      final semiMinor = Geodesy.wgs84A * (1 - Geodesy.wgs84F);

      expect(ecef.x, closeTo(0, 1e-6));
      expect(ecef.y, closeTo(0, 1e-6));
      expect(ecef.z, closeTo(semiMinor, 1e-6));
    });
  });

  group('Geodesy ECEF round trip', () {
    test('recovers latitude, longitude, and height', () {
      const original = GeoPoint(
        latitude: -6.2,
        longitude: 106.816666,
        height: 50,
      );

      final recovered = Geodesy.fromEcef(Geodesy.toEcef(original));

      expect(recovered.latitude, closeTo(original.latitude, 1e-9));
      expect(recovered.longitude, closeTo(original.longitude, 1e-9));
      expect(recovered.height, closeTo(original.height, 1e-3));
    });
  });

  group('Geodesy ENU', () {
    const origin = GeoPoint(latitude: -6.2, longitude: 106.816666, height: 100);

    test('round trips an offset point', () {
      const enu = EnuPoint(east: 100, north: 50, up: 2);
      final geo = Geodesy.fromEnu(enu, origin);
      final recovered = Geodesy.toEnu(geo, origin);

      expect(recovered.east, closeTo(100, 1e-6));
      expect(recovered.north, closeTo(50, 1e-6));
      expect(recovered.up, closeTo(2, 1e-6));
      expect(recovered.horizontalDistance, closeTo(math.sqrt(12500), 1e-6));
    });

    test('maps vertical offset to up component', () {
      const shifted = GeoPoint(
        latitude: -6.2,
        longitude: 106.816666,
        height: 110,
      );

      final enu = Geodesy.toEnu(shifted, origin);

      expect(enu.east, closeTo(0, 1e-6));
      expect(enu.north, closeTo(0, 1e-6));
      expect(enu.up, closeTo(10, 1e-6));
    });
  });

  group('Geodesy.horizontalDistance', () {
    test('one degree of latitude is about 111.2 km', () {
      const a = GeoPoint(latitude: 0, longitude: 0, height: 0);
      const b = GeoPoint(latitude: 1, longitude: 0, height: 0);

      expect(Geodesy.horizontalDistance(a, b), closeTo(111195.08, 0.01));
    });

    test('is zero for identical points', () {
      const point = GeoPoint(latitude: -6.2, longitude: 106.8, height: 10);

      expect(Geodesy.horizontalDistance(point, point), 0);
    });
  });
}
