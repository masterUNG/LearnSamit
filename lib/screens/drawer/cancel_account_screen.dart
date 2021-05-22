import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancelAccount extends StatefulWidget {
  CancelAccount({Key key}) : super(key: key);

  @override
  _CancelAccountState createState() => _CancelAccountState();
}

class _CancelAccountState extends State<CancelAccount> {
  Future<Null> confirmUnRegister() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Confirm UnRegister'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear();
                  await Timer(Duration(seconds: 5), () {
                    exit(0);
                  });
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยกเลิกการลงทะเบียน'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => confirmUnRegister(),
          child: Text('ยกเลิกการลงทะเบียน', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
