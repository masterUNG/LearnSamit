import 'package:ASmartApp/exception/app_exception.dart';
import 'package:ASmartApp/models/RegisterModel.dart';
import 'package:ASmartApp/models/rqrs/user_session/user_profile_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeDetailScreen({Key key}) : super(key: key);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  UserProfile _userProfile;

  String _macAddress;
  String _imei;

  @override
  void initState() {
    super.initState();
    readEmplyee();
  }

  // Call API
  readEmplyee() async {
    try {
      var connectResult = await Connectivity().checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
        return;
      }

      DialogUtil.showLoadingDialog(context);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      _imei = sharedPreferences.getString('storeDeviceIMEI');
      String pass = sharedPreferences.getString('pass');

      String macAddress = "Unknown";

      try {
        macAddress = await GetMac.macAddress;
      } on PlatformException {
        macAddress = "Faild to get Device MAC Address";
      }

      _macAddress = macAddress;

      BaacRestApiService service = BaacRestApiService();
      UserProfileRs _userProfileRs = await service.empDetail(_imei, pass);
      Navigator.pop(context);
      if (_userProfileRs == null || _userProfileRs.userProfiles == null || _userProfileRs.userProfiles.isEmpty) {
        DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'ไม่พบข้อมูลพนักงาน');
        return;
      }
      _userProfile = _userProfileRs?.userProfiles[0];
      setState(() {

      });

    } catch (error, stackTrace) {
      if (error is ErrorWebApiException) {
        Navigator.pop(context);
        DialogUtil.showWarningDialog(context, 'แจ้งเตือน', '${error.error}');
      } else {
        DialogUtil.showWarningDialog(context, 'แจ้งเตือน', '$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลพนักงาน'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('${_userProfile?.fNAMETH ?? "-"} ${_userProfile?.lNAMETH ?? "-"}'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสพนักงาน'),
            subtitle: Text('${_userProfile?.eMPLOYEEID ?? "..."}'),
          ),
          // ListTile(
          //   leading: Icon(Icons.person_pin),
          //   title: Text('เพศ'),
          //   subtitle: Text('${_userProfile?. ?? "..."}'),
          // ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('${_userProfile?.pOSITIONNAME ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('${_userProfile?.oRGANISATIONNAME ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('${_userProfile?.sALARY ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('${_userProfile?.bIRTHDATE ?? "..."}'),
          ),
          // ListTile(
          //   leading: Icon(Icons.email),
          //   title: Text('อีเมล์'),
          //   subtitle: Text('${_dataEmployee?.data?.email ?? "..."}'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.phone),
          //   title: Text('เบอร์โทรศัพท์'),
          //   subtitle: Text('${_dataEmployee?.data?.tel ?? "..."}'),
          // ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('${_userProfile?.aDDRESS ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('IMEI'),
            subtitle: Text('${_imei ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Mac Address'),
            subtitle: Text('${_macAddress ?? "..."}'),
          ),
        ],
      ),
    );
  }
}
