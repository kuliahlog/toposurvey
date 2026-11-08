import '../constants/app_constants.dart';

String qualityLabel(String quality) {
  return switch (quality) {
    QualityFlag.good => 'Baik',
    QualityFlag.fair => 'Cukup',
    QualityFlag.poor => 'Buruk',
    _ => quality,
  };
}

String methodLabel(String method) {
  return switch (method) {
    SurveyMethod.gnssBaro => 'GNSS + Barometer',
    SurveyMethod.gnss => 'GNSS',
    _ => method,
  };
}

String sessionModeLabel(String mode) {
  return switch (mode) {
    SessionMode.single => 'Single device',
    SessionMode.virtualAnchor => 'Virtual anchor (2 HP)',
    SessionMode.network => 'Network (3 HP)',
    _ => mode,
  };
}

String deviceRoleLabel(String role) {
  return switch (role) {
    DeviceRole.base => 'Base',
    DeviceRole.anchor => 'Anchor',
    DeviceRole.rover => 'Rover',
    _ => role,
  };
}
