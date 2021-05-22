import 'package:flutter/material.dart';
import 'package:ASmartApp/themes/colors.dart';

class DialogUtil {

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static Future<Null> showNormalDialog(BuildContext context, String string) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Icon(Icons.add_alert, size: 48, color: Colors.red.shade700,),
          title: Text(string),
        ),
        children: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> showCustomWidgetDialog(BuildContext context, String title, Widget widget) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: widget,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'ปิด',
                  )),
            ],
          );
        });
  }

  static Widget showProgress() => Center(child: CircularProgressIndicator());

  static Future<void> showWarningDialog(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorDialogWarningBackground,
          title: Row(
            children: <Widget>[
              Icon(Icons.warning, color: colorDialogWarningText),
              Padding(padding: EdgeInsets.only(right: 8)),
              Expanded(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: colorDialogWarningText),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message ?? '',
                  style: TextStyle(color: colorDialogWarningText),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'ตกลง',
                style: TextStyle(color: colorDialogWarningText),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showConfirmWarningDialog(BuildContext context, String title, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorDialogWarningBackground,
          title: Row(
            children: <Widget>[
              Icon(Icons.warning, color: colorDialogWarningText),
              Padding(padding: EdgeInsets.only(right: 8)),
              Expanded(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: colorDialogWarningText),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message ?? '',
                  style: TextStyle(color: colorDialogWarningText),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'ยกเลิก',
                style: TextStyle(color: colorDialogWarningText),
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'ตกลง',
                style: TextStyle(color: colorDialogWarningText),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showSuccessDialog(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorDialogInfoBackground,
          title: Row(
            children: <Widget>[
              Icon(Icons.check_circle_rounded, color: colorDialogInfoText),
              Padding(padding: EdgeInsets.only(right: 8)),
              Expanded(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: colorDialogInfoText),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message ?? '',
                  style: TextStyle(color: colorDialogInfoText),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'ตกลง',
                style: TextStyle(color: colorDialogInfoText),
              ),
            ),
          ],
        );
      },
    );
  }

}