import 'package:intl/intl.dart';

extension StringExt on String {
  String? formatDate({String? format}) {
    final date = DateTime.parse(this);
    final DateFormat dateFormat = DateFormat(format ?? 'dd MMMM yyyy');
    return dateFormat.format(date);
  }
}
