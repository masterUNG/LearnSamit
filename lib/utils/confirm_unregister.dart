import 'dart:async';
import 'dart:io';

import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> confirmUnRegister(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text('Confirm UnRegister ใส่ข้อความอธิบายของการ ออกจาก UnRegister'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                String storeDeviceIMEI =
                    preferences.getString('storeDeviceIMEI');
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
                        exit(0);
                      });
                    } else {
                      normalDialog(context, 'กรุญาลองใหม่');
                    }
                  }
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
