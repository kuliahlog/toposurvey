import 'dart:math' as math;

class GeoPoint {
  const GeoPoint({
    required this.latitude,
    required this.longitude,
    required this.height,
  });

  final double latitude;
  final double longitude;
  final double height;
}

class EcefPoint {
  const EcefPoint({required this.x, required this.y, required this.z});

  final double x;
  final double y;
  final double z;
}

class EnuPoint {
  const EnuPoint({required this.east, required this.north, required this.up});

  final double east;
  final double north;
  final double up;

  double get horizontalDistance => math.sqrt(east * east + north * north);
}

class Geodesy {
  const Geodesy._();

  static const double wgs84A = 6378137.0;
  static const double wgs84F = 1 / 298.257223563;
  static const double wgs84E2 = wgs84F * (2 - wgs84F);

  static EcefPoint toEcef(GeoPoint point) {
    final lat = _rad(point.latitude);
    final lon = _rad(point.longitude);
    final sinLat = math.sin(lat);
    final cosLat = math.cos(lat);
    final sinLon = math.sin(lon);
    final cosLon = math.cos(lon);

    final n = wgs84A / math.sqrt(1 - wgs84E2 * sinLat * sinLat);

    return EcefPoint(
      x: (n + point.height) * cosLat * cosLon,
      y: (n + point.height) * cosLat * sinLon,
      z: (n * (1 - wgs84E2) + point.height) * sinLat,
    );
  }

  static GeoPoint fromEcef(EcefPoint point) {
    final lon = math.atan2(point.y, point.x);
    final p = math.sqrt(point.x * point.x + point.y * point.y);
    var lat = math.atan2(point.z, p * (1 - wgs84E2));
    var height = 0.0;

    for (var i = 0; i < 6; i++) {
      final sinLat = math.sin(lat);
      final n = wgs84A / math.sqrt(1 - wgs84E2 * sinLat * sinLat);
      height = p / math.cos(lat) - n;
      lat = math.atan2(point.z, p * (1 - wgs84E2 * n / (n + height)));
    }

    return GeoPoint(latitude: _deg(lat), longitude: _deg(lon), height: height);
  }

  static EnuPoint toEnu(GeoPoint point, GeoPoint origin) {
    final originEcef = toEcef(origin);
    final pointEcef = toEcef(point);
    final dx = pointEcef.x - originEcef.x;
    final dy = pointEcef.y - originEcef.y;
    final dz = pointEcef.z - originEcef.z;

    final lat = _rad(origin.latitude);
    final lon = _rad(origin.longitude);
    final sinLat = math.sin(lat);
    final cosLat = math.cos(lat);
    final sinLon = math.sin(lon);
    final cosLon = math.cos(lon);

    return EnuPoint(
      east: -sinLon * dx + cosLon * dy,
      north: -sinLat * cosLon * dx - sinLat * sinLon * dy + cosLat * dz,
      up: cosLat * cosLon * dx + cosLat * sinLon * dy + sinLat * dz,
    );
  }

  static GeoPoint fromEnu(EnuPoint enu, GeoPoint origin) {
    final originEcef = toEcef(origin);
    final lat = _rad(origin.latitude);
    final lon = _rad(origin.longitude);
    final sinLat = math.sin(lat);
    final cosLat = math.cos(lat);
    final sinLon = math.sin(lon);
    final cosLon = math.cos(lon);

    final dx =
        -sinLon * enu.east -
        sinLat * cosLon * enu.north +
        cosLat * cosLon * enu.up;
    final dy =
        cosLon * enu.east -
        sinLat * sinLon * enu.north +
        cosLat * sinLon * enu.up;
    final dz = cosLat * enu.north + sinLat * enu.up;

    return fromEcef(
      EcefPoint(
        x: originEcef.x + dx,
        y: originEcef.y + dy,
        z: originEcef.z + dz,
      ),
    );
  }

  static double horizontalDistance(GeoPoint a, GeoPoint b) {
    const earthRadius = 6371008.8;
    final lat1 = _rad(a.latitude);
    final lat2 = _rad(b.latitude);
    final dLat = lat2 - lat1;
    final dLon = _rad(b.longitude - a.longitude);
    final h =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    return 2 * earthRadius * math.asin(math.min(1, math.sqrt(h)));
  }

  static double _rad(double degrees) => degrees * math.pi / 180;

  static double _deg(double radians) => radians * 180 / math.pi;
}
