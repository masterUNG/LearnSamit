import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
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
