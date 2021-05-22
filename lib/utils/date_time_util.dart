import 'package:ASmartApp/utils/string_util.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static DateTime toDateTime(String s, {String format}) {
    if (StringUtil.isNullOrEmpty(s)) {
      return null;
    }
    if (StringUtil.isNullOrEmpty(format)) {
      return DateTime.parse(s);
    }

    return DateFormat(format).parse(s);
  }

  static DateTime toDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  static DateTime truncate(DateTime d) {
    return DateTime(
      d.year,
      d.month,
      d.day,
    );
  }

  static String toDateTimeString(DateTime d, String format) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(d);
  }
}

const String APP_DATE_TIME_FORMAT = 'M/d/y hh:mm:ss aaa';