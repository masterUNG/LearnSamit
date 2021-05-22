import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyStyle {
  Color weakColor = Color(0xffaee571);
  Color primaryColor = Color(0xff7cb342);
  Color darkColor = Color(0xff4b830d);

  TextStyle whiteStyle() => TextStyle(color: Colors.white);

  Widget showProgress() => Center(child: CircularProgressIndicator());

  Widget showTitleH1(String string) => Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          bottom: 15.0,
        ),
        child: Text(
          string,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget showTitleH2(String string) => Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          bottom: 15.0,
        ),
        child: Text(
          string,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget showTitleH2NonBold(String string) => Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
        ),
        child: Text(
          string,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      );

  String cutWord(String string) {
    String content = string;
    if (content.length >= 100) {
      content = content.substring(0, 99);
      content = '$content ...';
    }
    return content;
  }

  String formatAmount(String string) {
    double douNumber;
    if (string == null) {
      douNumber = 0;
    } else {
      douNumber = double.parse(string.trim());
    }
    var myFormat = NumberFormat('#,###', 'en_US');
    String result = myFormat.format(douNumber);
    return result;
  }

  MyStyle();
}
