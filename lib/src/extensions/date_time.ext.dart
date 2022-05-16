import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get format => DateFormat('dd/MM/yyyy').format(this);
}
