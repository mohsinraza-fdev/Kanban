import 'package:intl/intl.dart';

extension AppDateTimeExtension on DateTime {
  toDDMMMYYYY() {
    return DateFormat('dd MMM, yyyy').format(this);
  }

  toHHMM24() {
    return DateFormat('hh:mm').format(this);
  }

  toHHMM12() {
    return DateFormat('hh:mm a').format(this);
  }
}
