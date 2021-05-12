import 'package:intl/intl.dart';

class TimeUtils {

  static String unixToHHmm(int unix) {
    var format = DateFormat.Hm();
    return format.format(DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true));
  }

  static String unixToWeekdayShortName(int unix) {
    var format = DateFormat.E();
    return format.format(DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true));
  }

  static String unixToFullDay(int unix) {
    var format = DateFormat.EEEE();
    return format.format(DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true));
  }

  static DateTime unixToDateTime(int unix) {
    return DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true);
  }
}
