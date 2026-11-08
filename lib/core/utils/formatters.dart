import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  static final _dateTime = DateFormat('dd/MM/yyyy HH:mm:ss');
  static final _date = DateFormat('dd/MM/yyyy');

  static String latitude(double value) => value.toStringAsFixed(7);

  static String longitude(double value) => value.toStringAsFixed(7);

  static String meters(double? value, {int decimals = 1}) {
    if (value == null || !value.isFinite) return '-';
    return '${value.toStringAsFixed(decimals)} m';
  }

  static String pressure(double? value) {
    if (value == null || !value.isFinite) return '-';
    return '${value.toStringAsFixed(2)} hPa';
  }

  static String dateTime(DateTime value) => _dateTime.format(value.toLocal());

  static String date(DateTime value) => _date.format(value.toLocal());

  static String seconds(int value) {
    final minutes = value ~/ 60;
    final seconds = value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  static String fileName(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }
}
