import 'package:ASmartApp/models/BaacTimeDetailModel.dart';
import 'package:ASmartApp/models/empleave_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
// import 'package:baacstaff/utils/utility.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowTimeDetail extends StatefulWidget {
  ShowTimeDetail({Key key}) : super(key: key);

  @override
  _ShowTimeDetailState createState() => _ShowTimeDetailState();
}

class _ShowTimeDetailState extends State<ShowTimeDetail> {
  // ข้อมูล body payload สำหรับแนบไปกับ post

  List<EmpleaveModel> empleaveModels = List();

  @override
  void initState() {
    super.initState();
    // getTimeDetail();
    readData();
  }

  Future<Null> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> mapImeiPass = Map();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    String urlPath = 'Empleave/';

    await CallAPI().postData(mapImeiPass, urlPath).then((value) {
      // print('########## value ShowTime ===>> $value ############');

      for (var json in value) {
        EmpleaveModel model = EmpleaveModel.fromJson(json);
        setState(() {
          empleaveModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานการลา'),
      ),
      body: empleaveModels.length == 0
          ? MyStyle().showProgress()
          : buildListEmpleave(),
    );
  }

  Widget buildListEmpleave() => ListView.builder(
        itemCount: empleaveModels.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Text('${index + 1}'),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ปีบัญชี ${empleaveModels[index].aCCOUNTYEAR}'),
                Text('ประเภทการลา ${empleaveModels[index].aBSENCETYPE}'),
                Text('ลาประเภท ${empleaveModels[index].aBSENCENAME}'),
                Text('โควต้าวันลา ${empleaveModels[index].qUOTADAY}'),
                Text('ใช้ไป ${empleaveModels[index].dAYUSED}'),
                Text('ชม.ลาใช้ไป ${empleaveModels[index].hOURUSED}'),
              ],
            ),
          ),
        ),
      );

  // สร้าง Widget List View ไว้สำหรับแสดงผล
  Widget _listViewTimeDetail(List<BaacTimeDetailModel> timedetails) {
    return ListView.builder(
        itemCount: timedetails.length,
        itemBuilder: (context, index) {
          BaacTimeDetailModel baacTimeDetailModel = timedetails[index];
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
                            Icon(
                              Icons.access_time,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(baacTimeDetailModel.type),
                          Text('วันที่ ' + baacTimeDetailModel.date),
                          Text('เวลา ' + baacTimeDetailModel.time)
                        ],
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
