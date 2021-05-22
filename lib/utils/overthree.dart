import 'dart:async';
import 'dart:io';

import 'package:ASmartApp/screens/register/register_screen.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> alertOverThree(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(string),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                String storeDeviceIMEI = preferences.getString('storeDeviceIMEI');
                String pass = preferences.getString('pass');
                print(
                    'stroreDeviceIMEI ===>>> $storeDeviceIMEI, ###### pass = $pass');

                Map<String, dynamic> data = Map();
                data['IMEI'] = storeDeviceIMEI;
                data['latitude'] = '12';
                data['longitude'] = '13';
                data['pass'] = pass;

                await CallAPI()
                    .postData(data, 'Unregister/')
                    .then((value) async {
                  for (var json in value) {
                    String statusCode = json['statusCode'];
                    if (statusCode == '01') {
                      preferences.clear();
                      await Timer(Duration(seconds: 5), () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                            (route) => false);
                      });
                    } else {
                      normalDialog(context, 'กรุญาลองใหม่');
                    }
                  }
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      ],
    ),
  );
}
