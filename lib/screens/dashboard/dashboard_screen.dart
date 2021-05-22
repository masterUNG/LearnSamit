import 'package:ASmartApp/screens/bottomnav/benefit_screen.dart';
import 'package:ASmartApp/screens/bottomnav/checkin_screen.dart';
import 'package:ASmartApp/screens/bottomnav/employee_screen.dart';
import 'package:ASmartApp/screens/bottomnav/fundloan_screen.dart';
import 'package:ASmartApp/screens/bottomnav/home_screen.dart';
import 'package:ASmartApp/screens/lockscreen/locksceen.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/confirm_unregister.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ASmartApp/themes/theme.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  // เรียกใช้ตัวแปร SharedPrefference
  SharedPreferences sharedPreferences;

  // สร้างตัวแปรไว้รับข้อมูลจาก SharedPreferences
  String fullnameAccount, empIDAccount, _avatar;

  // สร้างฟังก์ชันไว้ดึงข้อมูลตัวแปรแบบ sharedPreferences
  readEmployee() async {
    sharedPreferences = await SharedPreferences.getInstance();

    String storeDeviceIMEI = sharedPreferences.getString('storeDeviceIMEI');
    print('storeDeviceIMEI ===>> $storeDeviceIMEI');

    String pass = sharedPreferences.getString('pass');
    print('pass ==>> $pass');

    Map<String, dynamic> data = Map();
    data['IMEI'] = storeDeviceIMEI;
    data['pass'] = pass;

    await CallAPI().postData(data, 'EmpDetail/').then((value) {
      print('####### value =====>>> $value');

      for (var json in value) {
        // EmpModel model = EmpModel.fromJson(json);

        setState(() {
          empIDAccount = json['EMPLOYEE_ID'];
          fullnameAccount = 'คุณ ${json['FNAME_TH']} ${json['LNAME_TH']}';
          _avatar = '';
          print('empID ===>>>> $empIDAccount');
          print('fullName from dashboard =====>>>>> $fullnameAccount');
        });
      }
    });

    // setState(() {
    //   empIDAccount = sharedPreferences.getString('storeEmpID');
    //   fullnameAccount = sharedPreferences.getString('storePrename') +
    //       sharedPreferences.getString('storeFirstname') +
    //       " " +
    //       sharedPreferences.getString('storeLastname');
    //   _avatar = sharedPreferences.getString('storeAvatar');
    // });
  }

  // ฟังก์ชันออกจากระบบ
  signOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  // สถานะเมื่อหน้าจอโดนโหลดมาครั้งแรก
  @override
  void initState() {
    super.initState();
    print('============== initState Work ==============');

    WidgetsBinding.instance.addObserver(this);

    readEmployee();
    _actionWidget = _homeActionBar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print('============== initState Work ==============');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        print('============== inactive ==============');
        break;
      case AppLifecycleState.paused:
        print('============== paused ==============');
        setupStatus();
        break;
      case AppLifecycleState.resumed:
        print('============== resume ==============');
        checkStatus();
        break;
      default:
    }
  }

  Future<Null> checkStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int storeStep = preferences.getInt('storeStep');
    print('============== resume storeStep ==>> $storeStep ==============');

    if (storeStep == 4) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LockScreen(),
          ),
          (route) => false);
    }
  }

  Future<Null> setupStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int storeStep = preferences.getInt('storeStep');
    if (storeStep == 0) {
      return;
    }
    preferences.setInt('storeStep', 4);
  }



  // สร้างตัวแบบ list เก็บรายการหน้าของ tab bottom
  int _currentIndex = 0;
  String _title = 'หน้าหลัก';
  Widget _actionWidget;

  final List<Widget> _children = [
    HomeScreen(),
    BenefitScreen(),
    FundLoanScreen(),
    CheckinScreen(),
    EmployeeScreen()
  ];

  Widget homeScreenNew() {
    if (fullnameAccount == null) {
      return HomeScreen();
    } else {
      return HomeScreen(
        fullName: fullnameAccount,
      );
    }
  }

  // สร้าง Widget action สำหรับไว้แยกแสดงผลบน Appbar
  Widget _homeActionBar() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/scan');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [Icon(Icons.photo_camera), Text(' SCAN')],
        ),
      ),
    );
  }

  Widget _checkInActionBar() {
    return FlatButton(
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            Icons.timelapse,
            color: Colors.white,
          ),
          Text(
            ' ลงเวลาทำงาน',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // เขียนเงื่อนไขสลับการเปลี่ยน tab
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'หน้าหลัก';
          _actionWidget = _homeActionBar();
          break;
        case 1:
          _title = 'สวัสดิการ';
          _actionWidget = Container();
          break;
        case 2:
          _title = 'กองทุนกู้ยืมเพื่อ...';
          _actionWidget = Container();
          break;
        case 3:
          _title = 'ลงเวลาทำงาน';
          _actionWidget = _checkInActionBar();
          break;
        case 4:
          _title = 'ข้อมูลของฉัน';
          _actionWidget = Container();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('$_title'),
        actions: [_actionWidget],
      ),
      // ส่วนของเมนูด้านข้าง
      drawer: buildSafeAreaDrawer(context),
      // ส่วนเนื้อหา
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottonNav(),
    );
  }

  Container buildBottonNav() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              gap: 4,
              activeColor: Colors.white,
              iconSize: 16,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: Colors.green[800],
              color: Colors.teal,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'หน้าหลัก',
                ),
                GButton(
                  icon: Icons.enhanced_encryption,
                  text: 'สวัสดิการ',
                ),
                GButton(
                  icon: Icons.account_balance,
                  text: 'กองทุน',
                ),
                GButton(
                  icon: Icons.access_time,
                  text: 'ลงเวลา',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'ฉัน',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  onTabTapped(index);
                  _currentIndex = index;
                });
              }),
        ),
      ),
    );
  }

  SafeArea buildSafeAreaDrawer(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg')
                  // backgroundImage: AssetImage('assets/images/avatar.jpg')
                  ),
            ),
            accountName: Text('$fullnameAccount'),
            accountEmail: Text('$empIDAccount'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sidecover.jpg'),
                    fit: BoxFit.fill)),
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('ข้อมูลข่าวสาร ธกส.'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/baacnews');
            },
          ),
          ListTile(
            leading: Icon(Icons.rice_bowl),
            title: Text('ข้อมูลเกษตรกร'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/farmer_criteria');
            },
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Fit And Firm'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/fit_and_firm');
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('พื้นที่ให้บริการ'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/servicemap');
            },
          ),
          ListTile(
            leading: Icon(Icons.timelapse),
            title: Text('รายงานการลา'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/showtimedetail');
            },
          ),
          Divider(
            color: Colors.green[200],
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('ออกจากระบบ'),
            onTap: () {
              signOut();
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel),
            title: Text('ยกเลิกการลงทะเบียน'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/cancelaccount');
              confirmUnRegister(context);
            },
          ),
        ],
      ),
    ));
  }
}
