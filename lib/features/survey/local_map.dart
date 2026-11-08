import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/geo/geodesy.dart';
import '../../data/database/app_database.dart';
import '../common/quality_badge.dart';

class LocalSurveyMap extends StatelessWidget {
  const LocalSurveyMap({
    super.key,
    required this.project,
    required this.points,
    required this.livePosition,
    this.anchors = const [],
    this.anchorRanges,
    this.height = 260,
  });

  final Project project;
  final List<SurveyPoint> points;
  final Position? livePosition;
  final List<Anchor> anchors;
  final Map<String, double>? anchorRanges;
  final double height;

  @override
  Widget build(BuildContext context) {
    final origin = _resolveOrigin();
    final theme = Theme.of(context);

    if (origin == null) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.my_location,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                'Menunggu posisi GNSS pertama',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final mappedPoints = <_MappedPoint>[];
    for (final point in points) {
      final enu = Geodesy.toEnu(
        GeoPoint(
          latitude: point.lat,
          longitude: point.lon,
          height: point.orthoH,
        ),
        origin,
      );
      mappedPoints.add(
        _MappedPoint(
          enu: enu,
          label: point.code,
          color: qualityColor(context, point.quality),
        ),
      );
    }

    final mappedAnchors = <_MappedAnchor>[];
    for (final a in anchors) {
      final enu = Geodesy.toEnu(
        GeoPoint(latitude: a.lat, longitude: a.lon, height: a.ellipH),
        origin,
      );
      mappedAnchors.add(
        _MappedAnchor(
          enu: enu,
          label: a.label,
          rangeMeters: anchorRanges?[a.label] ?? anchorRanges?[a.id],
        ),
      );
    }

    _MappedLive? live;
    if (livePosition != null) {
      live = _MappedLive(
        enu: Geodesy.toEnu(
          GeoPoint(
            latitude: livePosition!.latitude,
            longitude: livePosition!.longitude,
            height: livePosition!.altitude,
          ),
          origin,
        ),
        accuracy: livePosition!.accuracy,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _SurveyMapPainter(
            points: mappedPoints,
            anchors: mappedAnchors,
            live: live,
            colorScheme: theme.colorScheme,
            textTheme: theme.textTheme,
          ),
        ),
      ),
    );
  }

  GeoPoint? _resolveOrigin() {
    if (project.originLat != null && project.originLon != null) {
      return GeoPoint(
        latitude: project.originLat!,
        longitude: project.originLon!,
        height: project.originEllipH ?? 0,
      );
    }
    if (livePosition != null) {
      return GeoPoint(
        latitude: livePosition!.latitude,
        longitude: livePosition!.longitude,
        height: livePosition!.altitude,
      );
    }
    if (points.isNotEmpty) {
      return GeoPoint(
        latitude: points.first.lat,
        longitude: points.first.lon,
        height: points.first.orthoH,
      );
    }
    if (anchors.isNotEmpty) {
      return GeoPoint(
        latitude: anchors.first.lat,
        longitude: anchors.first.lon,
        height: anchors.first.ellipH,
      );
    }
    return null;
  }
}

class _MappedAnchor {
  const _MappedAnchor({
    required this.enu,
    required this.label,
    this.rangeMeters,
  });

  final EnuPoint enu;
  final String label;
  final double? rangeMeters;
}

class _MappedPoint {
  const _MappedPoint({
    required this.enu,
    required this.label,
    required this.color,
  });

  final EnuPoint enu;
  final String label;
  final Color color;
}

class _MappedLive {
  const _MappedLive({required this.enu, required this.accuracy});

  final EnuPoint enu;
  final double accuracy;
}

class _SurveyMapPainter extends CustomPainter {
  _SurveyMapPainter({
    required this.points,
    required this.anchors,
    required this.live,
    required this.colorScheme,
    required this.textTheme,
  });

  final List<_MappedPoint> points;
  final List<_MappedAnchor> anchors;
  final _MappedLive? live;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = colorScheme.surfaceContainerLowest;
    canvas.drawRect(Offset.zero & size, background);

    final allEast = <double>[
      0,
      for (final point in points) point.enu.east,
      for (final a in anchors) ...[
        a.enu.east,
        if (a.rangeMeters != null) ...[
          a.enu.east - a.rangeMeters!,
          a.enu.east + a.rangeMeters!,
        ],
      ],
    ];
    final allNorth = <double>[
      0,
      for (final point in points) point.enu.north,
      for (final a in anchors) ...[
        a.enu.north,
        if (a.rangeMeters != null) ...[
          a.enu.north - a.rangeMeters!,
          a.enu.north + a.rangeMeters!,
        ],
      ],
    ];
    if (live != null) {
      allEast.add(live!.enu.east);
      allNorth.add(live!.enu.north);
    }

    var minEast = allEast.reduce(math.min);
    var maxEast = allEast.reduce(math.max);
    var minNorth = allNorth.reduce(math.min);
    var maxNorth = allNorth.reduce(math.max);

    const minimumSpan = 12.0;
    if (maxEast - minEast < minimumSpan) {
      final center = (maxEast + minEast) / 2;
      minEast = center - minimumSpan / 2;
      maxEast = center + minimumSpan / 2;
    }
    if (maxNorth - minNorth < minimumSpan) {
      final center = (maxNorth + minNorth) / 2;
      minNorth = center - minimumSpan / 2;
      maxNorth = center + minimumSpan / 2;
    }

    final padding = 34.0;
    final drawWidth = math.max(40.0, size.width - padding * 2);
    final drawHeight = math.max(40.0, size.height - padding * 2);
    final scale = math.min(
      drawWidth / (maxEast - minEast),
      drawHeight / (maxNorth - minNorth),
    );
    final centerEast = (minEast + maxEast) / 2;
    final centerNorth = (minNorth + maxNorth) / 2;

    Offset toCanvas(EnuPoint enu) {
      return Offset(
        size.width / 2 + (enu.east - centerEast) * scale,
        size.height / 2 - (enu.north - centerNorth) * scale,
      );
    }

    final gridStep = _niceStep(
      (maxEast - minEast) / 4,
      (maxNorth - minNorth) / 4,
    );
    final gridPaint = Paint()
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.45)
      ..strokeWidth = 1;

    final startEast = (minEast / gridStep).floor() * gridStep;
    for (var east = startEast; east <= maxEast + gridStep; east += gridStep) {
      final x = toCanvas(EnuPoint(east: east, north: 0, up: 0)).dx;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    final startNorth = (minNorth / gridStep).floor() * gridStep;
    for (
      var north = startNorth;
      north <= maxNorth + gridStep;
      north += gridStep
    ) {
      final y = toCanvas(EnuPoint(east: 0, north: north, up: 0)).dy;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final axisPaint = Paint()
      ..color = colorScheme.outline.withValues(alpha: 0.45)
      ..strokeWidth = 1.2;
    final originCanvas = toCanvas(const EnuPoint(east: 0, north: 0, up: 0));
    canvas.drawLine(
      Offset(originCanvas.dx, 0),
      Offset(originCanvas.dx, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, originCanvas.dy),
      Offset(size.width, originCanvas.dy),
      axisPaint,
    );

    if (live != null) {
      final liveCanvas = toCanvas(live!.enu);
      final accuracyRadius = math.max(8.0, live!.accuracy * scale);
      canvas.drawCircle(
        liveCanvas,
        accuracyRadius,
        Paint()..color = colorScheme.primary.withValues(alpha: 0.12),
      );
      canvas.drawCircle(liveCanvas, 7, Paint()..color = colorScheme.primary);
      canvas.drawCircle(
        liveCanvas,
        7,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = colorScheme.onPrimary,
      );
    }

    for (final point in points) {
      final center = toCanvas(point.enu);
      canvas.drawCircle(center, 6, Paint()..color = point.color);
      canvas.drawCircle(
        center,
        6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = colorScheme.surface,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: point.label,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, center + const Offset(9, -16));
    }

    for (final a in anchors) {
      final center = toCanvas(a.enu);
      if (a.rangeMeters != null && a.rangeMeters! > 0) {
        final radiusPx = a.rangeMeters! * scale;
        canvas.drawCircle(
          center,
          radiusPx,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2
            ..color = Colors.amber.withValues(alpha: 0.6),
        );
      }

      const triSize = 8.0;
      final path = Path()
        ..moveTo(center.dx, center.dy - triSize)
        ..lineTo(center.dx - triSize, center.dy + triSize * 0.7)
        ..lineTo(center.dx + triSize, center.dy + triSize * 0.7)
        ..close();

      canvas.drawPath(path, Paint()..color = Colors.amber.shade800);
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = colorScheme.surface,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: a.label,
          style: textTheme.labelSmall?.copyWith(
            color: Colors.amber.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, center + const Offset(10, -14));
    }

    _drawScaleBar(canvas, size, scale, gridStep);
    _drawNorthArrow(canvas, size);
  }

  double _niceStep(double eastRange, double northRange) {
    final raw = math.max(0.5, math.min(eastRange, northRange));
    final exponent = (math.log(raw) / math.ln10).floor();
    final base = math.pow(10, exponent).toDouble();
    final fraction = raw / base;
    final nice = fraction <= 1
        ? 1.0
        : fraction <= 2
        ? 2.0
        : fraction <= 5
        ? 5.0
        : 10.0;
    return nice * base;
  }

  void _drawScaleBar(Canvas canvas, Size size, double scale, double gridStep) {
    var lengthMeters = gridStep;
    while (lengthMeters * scale > size.width * 0.36) {
      lengthMeters /= 2;
    }
    final lengthPixels = lengthMeters * scale;
    final start = Offset(16, size.height - 22);
    final end = Offset(16 + lengthPixels, size.height - 22);

    final paint = Paint()
      ..color = colorScheme.onSurface
      ..strokeWidth = 2;
    canvas.drawLine(start, end, paint);
    canvas.drawLine(
      start + const Offset(0, -4),
      start + const Offset(0, 4),
      paint,
    );
    canvas.drawLine(end + const Offset(0, -4), end + const Offset(0, 4), paint);

    final label = lengthMeters >= 1
        ? '${lengthMeters.toStringAsFixed(lengthMeters >= 10 ? 0 : 1)} m'
        : '${(lengthMeters * 100).toStringAsFixed(0)} cm';
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurface),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, start + const Offset(0, -18));
  }

  void _drawNorthArrow(Canvas canvas, Size size) {
    final center = Offset(size.width - 24, 24);
    final path = Path()
      ..moveTo(center.dx, center.dy - 10)
      ..lineTo(center.dx - 6, center.dy + 8)
      ..lineTo(center.dx, center.dy + 4)
      ..lineTo(center.dx + 6, center.dy + 8)
      ..close();
    canvas.drawPath(path, Paint()..color = colorScheme.onSurface);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'N',
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(center.dx - 4, center.dy + 10));
  }

  @override
  bool shouldRepaint(covariant _SurveyMapPainter oldDelegate) => true;
}
