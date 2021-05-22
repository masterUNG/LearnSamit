import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ASmartApp/themes/theme.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  // สร้าง Object SharedPreferences
  SharedPreferences sharedPreferences;

  // Sign out
  signOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ข้อมูลพนักงาน'),
            onTap: () {
              Navigator.pushNamed(context, '/employeedetail');
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('เปลี่ยนรหัสผ่าน'),
            onTap: () {
              Navigator.pushNamed(context, '/changepassword');
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ติดต่อทีมงาน'),
            onTap: () {
              Navigator.pushNamed(context, '/contactus');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('ออกจากระบบ'),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
