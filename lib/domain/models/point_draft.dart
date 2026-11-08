class PointDraft {
  const PointDraft({
    required this.code,
    required this.layer,
    required this.latitude,
    required this.longitude,
    required this.orthometricHeight,
    required this.accuracyH,
    required this.accuracyV,
    required this.poleHeight,
    required this.method,
    required this.quality,
    required this.sampleCount,
    required this.stdLat,
    required this.stdLon,
    required this.stdAlt,
    required this.capturedAt,
    this.description,
    this.ellipsoidHeight,
    this.pressureHpa,
    this.basePressureHpa,
    this.relativeHeightM,
  });

  final String code;
  final String layer;
  final String? description;
  final double latitude;
  final double longitude;
  final double orthometricHeight;
  final double? ellipsoidHeight;
  final double accuracyH;
  final double? accuracyV;
  final double poleHeight;
  final String method;
  final String quality;
  final int sampleCount;
  final double stdLat;
  final double stdLon;
  final double stdAlt;
  final DateTime capturedAt;
  final double? pressureHpa;
  final double? basePressureHpa;
  final double? relativeHeightM;
}
