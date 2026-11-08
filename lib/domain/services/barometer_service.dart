import 'dart:math' as math;

import 'package:sensors_plus/sensors_plus.dart';

class BaroReading {
  const BaroReading({required this.pressureHpa, required this.timestamp});

  final double pressureHpa;
  final DateTime timestamp;
}

class BarometerService {
  Stream<BaroReading> readings() {
    return barometerEventStream().map(
      (event) =>
          BaroReading(pressureHpa: event.pressure, timestamp: DateTime.now()),
    );
  }

  static double relativeHeightMeters({
    required double pressureHpa,
    required double basePressureHpa,
  }) {
    if (pressureHpa <= 0 || basePressureHpa <= 0) return 0;
    return 44330 *
        (1 - math.pow(pressureHpa / basePressureHpa, 1 / 5.255)).toDouble();
  }
}
