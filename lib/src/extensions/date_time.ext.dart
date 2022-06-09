import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get format => DateFormat('dd/MM/yyyy').format(this);
  String get formatWithHour => DateFormat('dd/MM/yyyy HH:mm').format(this);
  DateTime next30Minutes() {
    final newMinute = minute > 30 ? 0 : 30;
    final newHour = hour + (newMinute == 0 ? 1 : 0);
    return DateTime(year, month, day, newHour, newMinute);
  }
}
