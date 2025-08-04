import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTimeFormated({required BuildContext context, required String time}) {
  final DateTime sent = DateTime.parse(time);
  final DateTime now = DateTime.now();
  if (sent.year == now.year && sent.month == now.month && sent.day == now.day) {
    return "Today At ${TimeOfDay.fromDateTime(sent).format(context)}";
  } else if (now.difference(sent).inDays == 1) {
    return 'Yesterday';
  } else {
    return '${sent.day}/${sent.month}/${sent.year}';
  }
}

String getChatTimeFormatted({
  required BuildContext context,
  required String time,
}) {
  final sent = DateTime.parse(time);
  final now = DateTime.now();
  final diff = now.difference(sent);

  // Less than 1 minute
  if (diff.inSeconds < 60) {
    return diff.inSeconds < 5 ? 'Just now' : '${diff.inSeconds} secs ago';
  }

  // Less than 1 hour
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} mins ago';
  }

  // Today
  if (sent.year == now.year && sent.month == now.month && sent.day == now.day) {
    return TimeOfDay.fromDateTime(sent).format(context);
  }

  // Yesterday
  if (diff.inDays == 1 &&
      sent.day == now.subtract(const Duration(days: 1)).day) {
    return 'Yesterday';
  }

  // Within last 7 days
  if (diff.inDays < 7) {
    return "${DateFormat('EEE').format(sent)} ${TimeOfDay.fromDateTime(sent).format(context)}"; // ex: Mon, Tue
  }

  // Older
  return DateFormat('dd/MM/yyyy').format(sent);
}
