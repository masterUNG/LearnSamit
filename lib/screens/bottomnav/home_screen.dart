import 'dart:convert';

import 'package:ASmartApp/models/NewsModel.dart';
import 'package:ASmartApp/models/news_baac_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class HomeScreen extends StatefulWidget {
  final String fullName;
  HomeScreen({Key key, this.fullName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  String _fullnameAccount, _avatar;

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  // สร้าง Ojbect Geolocator
  Position position;
  String _lat, _lon;

  List<NewsBaacModel> newsBaacModels = List();

  // ฟังก์ชันเช็คว่าผู้ใช้เปิด GPS แล้วหรือยัง
  _getPosition() async {
    bool _isLocationServiceEnabled = await isLocationServiceEnabled();
    if (_isLocationServiceEnabled) {
      position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _lat = position.latitude.toString();
      _lon = position.longitude.toString();
      sharedPreferences = await SharedPreferences.getInstance();
      String storeDeviceIMEI = sharedPreferences.getString('storeDeviceIMEI');
      String pass = sharedPreferences.getString('pass');


      showDialog(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
                // title: Text('เลือกลงเวลาทำงาน'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('วันที่ $_currentDate'),
                        Text('เวลา $_currentTime')
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('ลงเวลาเข้าทำงาน'),
                    onTap: () {
                      Map<String, dynamic> body = {
                        "IMEI": storeDeviceIMEI,
                        "latitude": _lat??"12",
                        "longitude": _lon??"13",
                        "Type": "1"
                      };

                      checkInCheckOut(body);

                      Utility.getInstance().showAlertDialog(
                          context,
                          'เรียบร้อย',
                          'บันทึกเวลาเข้าทำงานเรียบร้อยแล้ว\nที่พิกัด $_lat, $_lon',
                          'ตกลง');
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.time_to_leave),
                    title: Text('ลงเวลาออกงาน'),
                    onTap: () {
                      Utility.getInstance().showAlertDialog(
                          context,
                          'เรียบร้อย',
                          'บันทึกเวลาออกงานเรียบร้อยแล้ว\nที่พิกัด $_lat, $_lon',
                          'ตกลง');
                      // Navigator.pop(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      OutlineButton(
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                        color: Colors.red,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ));
    } else {
      Utility.getInstance().showAlertDialog(
          context, 'คุณยังไม่ได้เปิด GPS', 'กรุณาเปิดก่อนใช้งาน');
    }
  }

  checkInCheckOut(empData) async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(
          context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต', 'ตกลง');
    } else {
      var response = await CallAPI().checkInAndOut(empData, 'Golocation');

      var body = json.decode(response.body);
      print(body);
    }
  }

  // สร้างฟังก์ชันไว้ดึงข้อมูลตัวแปรแบบ sharedPreferences
  readEmployee() async {
    // sharedPreferences = await SharedPreferences.getInstance();
    // setState(() {
    //   _fullnameAccount = sharedPreferences.getString('storeFirstname') +
    //       " " +
    //       sharedPreferences.getString('storeLastname');
    //   _avatar = sharedPreferences.getString('storeAvatar');
    // });
    // _fullnameAccount = widget.fullName;

    sharedPreferences = await SharedPreferences.getInstance();
    String storeDeviceIMEI = sharedPreferences.getString('storeDeviceIMEI');
    String pass = sharedPreferences.getString('pass');

    Map<String, dynamic> data = Map();
    data['IMEI'] = storeDeviceIMEI;
    data['pass'] = pass;

    await CallAPI().postData(data, 'EmpDetail/').then((value) {
      print('####### value =====>>> $value');

      for (var json in value) {
        // EmpModel model = EmpModel.fromJson(json);

        setState(() {
          // empIDAccount = json['EMPLOYEE_ID'];
          _fullnameAccount = 'คุณ ${json['FNAME_TH']} ${json['LNAME_TH']}';
          _avatar = '';
          // print('empID ===>>>> $empIDAccount');
          print('fullName =====>>>>> $_fullnameAccount');
        });
      }
    });

  }

  @override
  void initState() {
    super.initState();
    readEmployee();
    readNewsThread();
  }

  Future<Null> readNewsThread() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String storeDeviceIMEI = sharedPreferences.getString('storeDeviceIMEI');
    String pass = sharedPreferences.getString('pass');

    Map<String, dynamic> map = Map();
    map['IMEI'] = storeDeviceIMEI;
    map['pass'] = pass;

    var result = await CallAPI().postData(map, 'News/');
    print('######### $result ###########');
    for (var json in result) {
      NewsBaacModel model = NewsBaacModel.fromJson(json);
      setState(() {
        newsBaacModels.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        buildFirst(),
        buildTitle(),
        buildListNewsHorizontal(context),
        buildTitle2(),
        buildListNewsVertical(context),
      ]),
    );
  }

  Container buildListNewsVertical(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: newsBaacModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: newsBaacModels.length,
              itemBuilder: (context, index) => ListTile(onTap: () => openUrl(newsBaacModels[index].newLink),
                leading: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  width: 80,
                  height: 80,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: newsBaacModels[index].newPic,
                    placeholder: (context, url) => MyStyle().showProgress(),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/question.png'),
                  ),
                ),
                title: MyStyle().showTitleH1(newsBaacModels[index].newHead),
                subtitle: MyStyle().showTitleH2NonBold(
                    MyStyle().cutWord(newsBaacModels[index].newDetail)),
              ),
            ),
    );
  }

  Padding buildTitle2() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
      child: Text(
        'ข่าวทั้งหมด',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildListNewsHorizontal(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5 + 10,
      child: newsBaacModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              shrinkWrap: true,
              // physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: newsBaacModels.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => openUrl(newsBaacModels[index].newLink),
                child: Card(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 150,
                            width: 200,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: newsBaacModels[index].newPic,
                              placeholder: (context, url) =>
                                  MyStyle().showProgress(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/question.png'),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: MyStyle()
                                .showTitleH1(newsBaacModels[index].newHead),
                          ),
                          Container(
                            width: 200,
                            child: MyStyle().showTitleH2NonBold(MyStyle()
                                .cutWord(newsBaacModels[index].newDetail)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Read More',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<Null> openUrl(String string) async {
    print('url ====>>> $string');
    if (await url_launcher.canLaunch(string)) {
      await url_launcher.launch(string);
    }
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
      child: Text(
        'ข่าวประกาศล่าสุด',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildFirst() {
    return Container(
      width: double.infinity,
      height: 120.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_account.jpg'),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 32,
                    // backgroundColor: Color(0xffffffff),
                    child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/images/avatar.jpg')
                            
                            )
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'สวัสดี',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        '$_fullnameAccount',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          _getPosition();
                        },
                        child: Text(
                          'ลงเวลาทำงาน',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ListView builder
  Widget _builderListView(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: InkWell(
              onTap: () =>
                  url_launcher.launch('https://pub.dev/packages/url_launcher'),
              child: Card(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newsModel.imageurl != null
                          ? Container(
                              height: 125.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        newsModel.imageurl,
                                      ),
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.topCenter)))
                          : CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(newsModel.topic,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            Text(newsModel.detail,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // ListView All news
  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: news.length,
        itemBuilder: (context, index) {
          NewsModel newsModel = news[index];
          return ListTile(
            leading: Icon(Icons.new_releases),
            title: Text(newsModel.topic, overflow: TextOverflow.ellipsis),
            subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
            onTap: () {
              Utility.getInstance()
                  .showAlertDialog(context, newsModel.topic, newsModel.detail);
            },
          );
        });
  }
}
