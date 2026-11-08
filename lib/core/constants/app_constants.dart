class AppConstants {
  const AppConstants._();

  static const appName = 'TopoSurvey';
  static const captureDuration = Duration(seconds: 60);
  static const minSamples = 15;
  static const recommendedSamples = 30;
  static const maxGnssAccuracyMeters = 50.0;
  static const defaultPoleHeightMeters = 1.5;
}

class SessionMode {
  const SessionMode._();

  static const single = 'single';
  static const virtualAnchor = 'virtual_anchor';
  static const network = 'network';
}

class DeviceRole {
  const DeviceRole._();

  static const base = 'base';
  static const anchor = 'anchor';
  static const rover = 'rover';
}

class SurveyMethod {
  const SurveyMethod._();

  static const gnss = 'gnss';
  static const gnssBaro = 'gnss+baro';
  static const trilateration = 'trilateration';
  static const networkAdjustment = 'network_adj';
}

class QualityFlag {
  const QualityFlag._();

  static const good = 'good';
  static const fair = 'fair';
  static const poor = 'poor';
}
