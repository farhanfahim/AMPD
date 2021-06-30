import 'package:intl/intl.dart';

class TimerUtils {
  static int getSecondsInt(String time) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal();
    var converted = DateFormat("ss").format(timeParsed);
    return int.parse(converted);
  }

  static bool isAheadOrBefore(String time) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal().difference(DateTime.now());
    return timeParsed.isNegative;
  }

  static String getDays(String time, String type) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal().difference(DateTime.now());
//    var converted = DateFormat("dd").format(timeParsed);
    switch(type) {
      case 'days':
        return timeParsed.inDays.toString().padLeft(2, '0');
      case 'hours':
        return ((timeParsed.inHours % 24)).toString().padLeft(2, '0');
      case 'min':
        return ((timeParsed.inMinutes ) % 60).toString().padLeft(2, '0');
      case 'sec':
        return (timeParsed.inSeconds % 60).toString().padLeft(2, '0');
    }
  }

  static String getHours(String time) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal();
    var converted = DateFormat("hh").format(timeParsed);
    return converted;
  }

  static String getMin(String time) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal();
    var converted = DateFormat("mm").format(timeParsed);
    return converted;
  }

  static String getSec(String time) {
    var timeParsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true).toLocal();
    var converted = DateFormat("ss").format(timeParsed);
    return converted;
  }
}