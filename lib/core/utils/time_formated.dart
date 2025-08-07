import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Cache for DateFormat instances to avoid repeated instantiation
class _DateFormatCache {
  static final Map<String, DateFormat> _cache = {};

  static DateFormat get(String pattern) {
    return _cache.putIfAbsent(pattern, () => DateFormat(pattern));
  }

  static void clear() {
    _cache.clear();
  }
}

// Cache for common time calculations
class _TimeCache {
  static DateTime? _lastNow;
  static int _lastNowTimestamp = 0;
  static const int _cacheValidityMs = 1000; // 1 second cache

  static DateTime get now {
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (_lastNow == null ||
        currentTimestamp - _lastNowTimestamp > _cacheValidityMs) {
      _lastNow = DateTime.now();
      _lastNowTimestamp = currentTimestamp;
    }
    return _lastNow!;
  }

  static void clear() {
    _lastNow = null;
    _lastNowTimestamp = 0;
  }
}

/// Formats time with improved performance and user experience
String getTimeFormated({
  required BuildContext context,
  required String time,
  String? customTodayText,
  String? customYesterdayText,
  bool showTime = true,
}) {
  try {
    final DateTime sent = DateTime.parse(time);
    final DateTime now = _TimeCache.now;

    // Check if it's today
    if (_isSameDay(sent, now)) {
      if (!showTime) return customTodayText ?? 'Today';
      return "'Today' At ${TimeOfDay.fromDateTime(sent).format(context)}";
    }

    // Check if it's yesterday
    if (_isYesterday(sent, now)) {
      return customYesterdayText ?? 'Yesterday';
    }

    // Format date
    return _DateFormatCache.get('dd/MM/yyyy').format(sent);
  } catch (e) {
    // Return original time string if parsing fails
    return time;
  }
}

/// Formats chat time with improved performance and better UX
String getChatTimeFormatted({
  required BuildContext context,
  required String time,
  bool showSeconds = false,
  bool showFullDate = false,
}) {
  try {
    final sent = DateTime.parse(time);
    final now = _TimeCache.now;
    final diff = now.difference(sent);

    // Less than 1 minute
    if (diff.inSeconds < 60) {
      if (diff.inSeconds < 5) {
        return 'Just now';
      }
      if (showSeconds) {
        return '${diff.inSeconds} secs ago';
      }
      return 'Just now';
    }

    // Less than 1 hour
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} mins ago';
    }

    // Today
    if (_isSameDay(sent, now)) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    // Yesterday
    if (_isYesterday(sent, now)) {
      return 'Yesterday';
    }

    // Within last 7 days
    if (diff.inDays < 7) {
      final dayFormat = _DateFormatCache.get('EEE').format(sent);
      final timeFormat = TimeOfDay.fromDateTime(sent).format(context);
      return "$dayFormat $timeFormat";
    }

    // Older - show full date if requested
    if (showFullDate) {
      return _DateFormatCache.get('dd/MM/yyyy').format(sent);
    }

    // Show relative date for older messages
    if (diff.inDays < 30) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).round();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (diff.inDays / 365).round();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  } catch (e) {
    // Return original time string if parsing fails
    return time;
  }
}

/// Helper method to check if two dates are the same day
bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

/// Helper method to check if a date is yesterday
bool _isYesterday(DateTime date, DateTime now) {
  final yesterday = now.subtract(const Duration(days: 1));
  return _isSameDay(date, yesterday);
}

/// Clears all caches (useful for testing or memory management)
void clearTimeFormatCaches() {
  _DateFormatCache.clear();
  _TimeCache.clear();
}
