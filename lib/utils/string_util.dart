import 'package:intl/intl.dart';

class StringUtil {
  static String toFormatAmount(String string) {
    if (StringUtil.isNullOrEmpty(string)) {
      return '0';
    }
    double douNumber = double.parse(string.trim());
    var myFormat = NumberFormat('#,###', 'en_US');
    String result = myFormat.format(douNumber);
    return result;
  }

  static String toFormatCurrency(num price) {
    if (price == null) {
      return NumberFormat.currency(customPattern: '#,###.##').format(0)?.toString();
    }
    return NumberFormat.currency(customPattern: '#,###.##').format(price)?.toString();
  }

  static bool isNullOrEmpty(String s) {
    if (s == null) {
      return true;
    }

    if (s?.isEmpty ?? true) {
      return true;
    }

    if (s.trim() == '') {
      return true;
    }

    return false;
  }

  static bool isNotEmpty(String s) {
    return !isNullOrEmpty(s);
  }

  static bool isEmailPattern(String email) {
    if (isNullOrEmpty(email)) {
      return false;
    }

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }

  static String toShortWord(String string) {
    String content = string;
    if (content.length >= 100) {
      content = content.substring(0, 99);
      content = '$content ...';
    }
    return content;
  }

  static String toTruncDateFormat(DateTime dateTime, {String format}) => dateTime == null
      ? ''
      : format == null
          ? DateFormat('dd/MM/yyyy').format(dateTime)
          : DateFormat(format).format(dateTime);
}
