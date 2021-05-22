import 'package:ASmartApp/models/register_model.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/normal_dialog.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ASmartApp/services/rest_api.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // สร้างตัวแปรสำหรับผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  String empID, cizID;

  // สร้างตัวแปรไว้เก็บค่า IMEI และ MacAddress ของเครื่อง
  String _imeiNumber;
  String _macAddress;

  double lat = 0, lng = 0;

  // ฟังก์ชันอ่านข้อมูล IMEI และ Mac Address
  Future<void> initPlatformState() async {
    String imeiNumber = "Unknown";
    String macAddress = "Unknown";

    try {
      imeiNumber = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      macAddress = await GetMac.macAddress;
    } on PlatformException {
      macAddress = "Faild to get Device MAC Address";
    }

    if (!mounted) return;

    setState(() {
      _imeiNumber = imeiNumber;
      _macAddress = macAddress;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    if (locationData != null) {
      lat = locationData.latitude;
      lng = locationData.longitude;
    } else {
      lat = 0;
      lng = 0;
    }
    print('lat ===>>>$lat, lng ===>>> $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  // image: AssetImage('assets/images/logo.png')
                  image: AssetImage('assets/images/baac_bgstaff_register.jpg'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLogo(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      size: 28,
                                    ),
                                    labelText: 'รหัสพนักงาน',
                                    errorStyle: TextStyle(fontSize: 16)
                                    // hintText: 'กรุณากรอกรหัสพนักงาน 10 หลัก'
                                    ),
                                maxLength: 7,
                                // initialValue: '7777777',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณากรอกรหัสพนักงานก่อน';
                                  } else if (value.length != 7) {
                                    return 'กรุณาป้อนรหัสพนักงาน 7 หลัก';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  empID = value.trim();
                                },
                              ),
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.credit_card,
                                      size: 28,
                                    ),
                                    labelText: 'เลขบัตรประชาชน',
                                    errorStyle: TextStyle(fontSize: 16)
                                    // hintText: 'กรุณากรอกบัตรประชาชน 13 หลัก'
                                    ),
                                maxLength: 13,
                                // initialValue: '3770400404433',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณากรอกเลขบัตรประชาชนก่อน';
                                  } else if (value.length != 13) {
                                    return 'กรุณาป้อนบัตรประชาชน 13 หลัก';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  cizID = value.trim();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/consent');
                        // Call API Register

                        // print('You Click Register');

                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          print('empid ==>$empID, cizid ==>> $cizID, _imeiNumber ==>> $_imeiNumber');

                          Map<String, dynamic> map = Map();
                          map['EmpID'] = empID;
                          map['CizID'] = cizID;
                          map['IMEI'] = _imeiNumber;
                          map['latitude'] = lat.toString();
                          map['longitude'] = lng.toString();

                          print('map ===>> ${map.toString()}');


                          Navigator.pushNamed(context, '/consent', arguments: map);

                          // _register(map);

                          // var empData = {'empid': empID, 'cizid': cizID};
                          // var empData = {
                          //   'EmpID': '5601937',
                          //   'CizID': '1401800036854',
                          //   'IMEI': '123456789',
                          //   'latitude': '12',
                          //   'longgitude': '13'
                          // };
                          // _register(empData);
                          // Navigator.pushNamed(context, '/consent');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: Text(
                          'ลงทะเบียน',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildLogo() {
    return Column(
                    children: [
                      Image.asset(
                        'assets/images/astaff_logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  );
  }

  // ฟังก์ชันเช็คการลงทะเบียน
  void _register(empData) async {
    // เช็คว่าเครื่องผู้ใช้ online หรือ offline
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      // ถ้า offline อยู่
      print('คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
      // แสดง alert popup
      Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
    } else {
      // ถ้า online แล้ว
      // เรียกต่อ API ลงทะเบียน
      DialogUtil.showLoadingDialog(context);
      var response = await CallAPI().postData(empData, 'Register/');
      // print('########## response ===>>> $response ############');

      Navigator.pop(context);

      for (var json in response) {
        RegisterBaacModel model = RegisterBaacModel.fromJson(json);

        if (model.statusCode == '01') {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

          sharedPreferences.setString('storeDeviceIMEI', _imeiNumber); // เก็บ EMEI
          sharedPreferences.setString('storeEmpID', empID); // รหัสพนักงาน
          sharedPreferences.setString('EmpName', model.empName); // ชื่อพนักงาน
          sharedPreferences.setInt('storeStep', 1);

          Navigator.pushNamed(context, '/consent');
        } else {
          normalDialog(context, model.statusDesc);
        }
      }

      // เช็คว่าถ้าลงทะเบียนสำเร็จจะส่งไปหน้า consent

      //#######################################################
      // if (body['code'] == '200') {
      //   //  if (true) {
      //   // ส่งไปหน้า consent
      //   // สร้างตัวแปรประเภท SharedPrefference เก็บข้อมูลในแอพ

      //   // เก็บค่าที่ต้องการลง SharedPrefference

      //   sharedPreferences.setString('storeIMEI', _imeiNumber); // เก็บ EMEI
      //   sharedPreferences.setString('storePass', 'baac'); // เก็บ Pass

      //   sharedPreferences.setString('storeMac', _macAddress); // เก็บ MacAddress

      //   sharedPreferences.setString(
      //       'storeCizID', body['data']['cizid']); // บัตรประชาชน

      //   sharedPreferences.setString('storePrename', body['data']['prename']);
      //   sharedPreferences.setString(
      //       'storeFirstname', body['data']['firstname']);
      //   sharedPreferences.setString('storeLastname', body['data']['lastname']);
      //   sharedPreferences.setString('storePosition', body['data']['position']);
      //   sharedPreferences.setString('storeAvatar', body['data']['avatar']);

      //   //#########################################################
      // } else {
      //   Utility.getInstance().showAlertDialog(
      //       context, 'มีข้อผิดพลาด', 'ข้อมูลลงทะเบียนไม่ถูกต้อง ลองใหม่');
      // }
    }
  }
}
