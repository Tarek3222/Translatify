import 'package:flutter/material.dart';

String getTimeFormated({required BuildContext context, required String time}) {
  final DateTime sent = DateTime.parse(time);
  final DateTime now = DateTime.now();
  if (sent.year == now.year && sent.month == now.month && sent.day == now.day) {
    return TimeOfDay.fromDateTime(sent).format(context);
  } else if (now.difference(sent).inDays == 1) {
    return 'Yesterday';
  } else {
    return '${sent.day}/${sent.month}/${sent.year}';
  }
}
