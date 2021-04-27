import 'package:intl/intl.dart';

class TimeUtil {
  static const SECOND_MILLIS = 1000;
  static const MINUTE_MILLIS = 60 * SECOND_MILLIS;
  static const HOUR_MILLIS = 60 * MINUTE_MILLIS;
  static const DAY_MILLIS = 24 * HOUR_MILLIS;
  static final f = new DateFormat('dd/MM/yyyy hh:mm a');

  static String getDateAndTime(int time) {
    return f.format(DateTime.fromMillisecondsSinceEpoch(time)).toString();
  }

  static String getDuration(int duration) {
    String d = '';

    if (duration >= DAY_MILLIS) {
      d += '${duration ~/ DAY_MILLIS} Days ';
      duration %= DAY_MILLIS;
    }

    if (duration >= HOUR_MILLIS) {
      d += '${duration ~/ HOUR_MILLIS} Hours ';
      duration %= HOUR_MILLIS;
    }

    if (duration >= MINUTE_MILLIS) {
      d += '${duration ~/ MINUTE_MILLIS} Minutes ';
      duration %= MINUTE_MILLIS;
    }

    if (duration >= SECOND_MILLIS) {
      d += '${duration ~/ SECOND_MILLIS} Seconds ';
      duration %= SECOND_MILLIS;
    }

    if (duration >= 1) {
      d += '$duration Milliseconds ';
      duration %= 1;
    }

    return d;
  }
}
