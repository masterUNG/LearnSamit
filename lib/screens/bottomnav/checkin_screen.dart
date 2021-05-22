import 'package:ASmartApp/models/TimeDetailModel.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({Key key}) : super(key: key);

  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  List<TimeDetailModel> _timeDetails = [];

  Future<Null> readTimeDetail() async {
    setState(() {
      _timeDetails.clear();
    });
    Map<String, dynamic> mapImeiPass = Map();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    String url = 'TimeDetail/';
    var result = await CallAPI().postData(mapImeiPass, url);
    for (var json in result) {
      TimeDetailModel model = TimeDetailModel.fromJson(json);
      setState(() {
        _timeDetails.add(model);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getTimeDetail();
    readTimeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _timeDetails.length != 0
          ? RefreshIndicator(
              child: Container(
                child: _listViewTimeDetail(_timeDetails),
              ),
              onRefresh: readTimeDetail,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  // สร้าง ListView แสดงรายการ TimeDetail
  Widget _listViewTimeDetail(List<TimeDetailModel> timedetail) {
    return ListView.builder(
        itemCount: timedetail.length,
        itemBuilder: (context, index) {
          TimeDetailModel timeDetailModel = timedetail[index];
          return Container(
            child: Card(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/avatar.jpg',
                              width: 55,
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(timeDetailModel.type), Text('วันที่ ' + timeDetailModel.date), Text('เวลา ' + timeDetailModel.time)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
