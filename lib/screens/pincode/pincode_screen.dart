import 'package:ASmartApp/services/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeScreen extends StatefulWidget {
  PinCodeScreen({Key key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String storeDeviceIMEI;

  @override
  void initState() {
    super.initState();
    findOtp();
  }

  Future<Null> findOtp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    storeDeviceIMEI = preferences.getString('storeDeviceIMEI');
    print('storeDeviceIMEI ===>>> $storeDeviceIMEI');
  }

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 100));
    print('otp user ==> $otp');

    Map<String, dynamic> data = Map();
    data['IMEI'] = storeDeviceIMEI;
    data['PinCode'] = otp;
    data['latitude'] = '12';
    data['longitude'] = '13';

    String statusCode;

    await CallAPI().postData(data, 'CheckSetPinCode/').then((value) {
      statusCode = value['statusCode'];
      print('statusCode ==>> $statusCode');
     
    });

    if (statusCode == '01') {
        // return "ป้อนรหัสยืนยันถูกต้อง";
        return null;
      } else {
        return "รหัสที่ยืนยันที่ป้อนไม่ถูกต้อง";
      }

    // if (otp == "123456") {
    //   // return "ป้อนรหัสยืนยันถูกต้อง";
    //   return null;
    // } else {
    //   return "รหัสที่ยืนยันที่ป้อนไม่ถูกต้อง";
    // }
  }

  void moveToNextScreen(context) {
    // print('moveToNextScreen Workkkkkkk');
    _checkPincode(context);
  }

  @override
  Widget build(BuildContext context) {
    // ตั้งค่าล็อก Screen เป็นแนวตั้ง
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('กรอกรหัสยืนยันที่ได้รับจากอีเมล์'),
      // ),
      body: OtpScreen(
        otpLength: 6,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        themeColor: Colors.black,
        titleColor: Colors.teal,
        title: "รหัสยืนยันที่ได้รับจากอีเมล์",
        // subTitle: "Enter the code sent to \n +919876543210",
        subTitle: "",
        icon: Icon(Icons.email),
      ),
    );
  }

  void _checkPincode(BuildContext context) async {
    // สร้างตัวแปรเก็บข้อมูลแบบ SharedPreferrences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 2);
    // ส่งไปหน้า set password
    Navigator.pushReplacementNamed(context, '/setpassword');
  }
}
