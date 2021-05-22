import 'package:ASmartApp/exception/app_exception.dart';
import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rq.dart';
import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:ASmartApp/themes/theme.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerCriteria extends StatefulWidget {
  @override
  _FarmerCriteriaState createState() => _FarmerCriteriaState();
}

class _FarmerCriteriaState extends State<FarmerCriteria> {
  String conditionGroupValue = 'ID';

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _refresh() async {
    idController.clear();
    nameController.clear();
    lastNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลเกษตรกร'),
      ),
      body: RefreshIndicator(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              buildSearchCondition(),
              buildTextFillById(),
              buildTextFillByNameLastname(),
              buildButtonSearch(context),
            ],
          ),
        ),
        onRefresh: _refresh,
      ),
    );
  }

  Widget buildSearchCondition() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'เลือกเงื่อนไขการค้นหาข้อมูลเกษตรกร',
                    style: Theme.of(context).textTheme.normalBlack,
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                'เลขประจำตัวประชาชน',
                style: Theme.of(context).textTheme.smallBlack,
              ),
              leading: Radio(
                value: 'ID',
                groupValue: conditionGroupValue,
                onChanged: (String value) {
                  setState(() {
                    nameController.clear();
                    lastNameController.clear();
                    conditionGroupValue = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                'ชื่อ-นามสกุล',
                style: Theme.of(context).textTheme.smallBlack,
              ),
              leading: Radio(
                value: 'NAME_LASTNAME',
                groupValue: conditionGroupValue,
                onChanged: (String value) {
                  setState(() {
                    idController.clear();
                    conditionGroupValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFillById() {
    if (conditionGroupValue != 'ID') {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(13),
                      ],
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: 'เลขบัตรประชาชน',
                        hintText: 'เลขบัตรประชาชน',
                        icon: Icon(Icons.person),
                        suffixIcon: Visibility(
                          visible: idController.text.length > 0,
                          child: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                idController.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFillByNameLastname() {
    if (conditionGroupValue != 'NAME_LASTNAME') {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ',
                        hintText: 'ชื่อ',
                        icon: Icon(Icons.person),
                        suffixIcon: Visibility(
                          visible: nameController.text.length > 0,
                          child: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                nameController.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'นามสกุล',
                        hintText: 'นามสกุล',
                        icon: Icon(Icons.person),
                        suffixIcon: Visibility(
                          visible: lastNameController.text.length > 0,
                          child: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                lastNameController.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: RaisedButton.icon(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            label: new Text(
              'ค้นหา',
              style: Theme.of(context).textTheme.normalWhite,
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              try {
                if (conditionGroupValue == 'ID') {
                  if (idController.text.length != 13) {
                    throw ValidateException('กรุณาระบุรหัสประชาชนให้ครบ 13 หลัก');
                  }
                } else if (conditionGroupValue == 'NAME_LASTNAME') {
                  if (StringUtil.isNullOrEmpty(nameController.text) || StringUtil.isNullOrEmpty(lastNameController.text)) {
                    throw ValidateException('กรุณาระบุชื่อและนามสกุล');
                  }
                }

                SharedPreferences preferences = await SharedPreferences.getInstance();
                String imei = preferences.getString('storeDeviceIMEI');
                String pass = preferences.getString('pass');

                FarmerDetailRq farmerDetailRq = FarmerDetailRq()
                  ..imei = imei
                  ..pass = pass
                  ..citizenId = idController.text
                  ..firstName = nameController.text
                  ..lastName = lastNameController.text;

                DialogUtil.showLoadingDialog(context);
                FarmerDetailRs farmerDetailRs = await BaacRestApiService().fAMSearchDetail(farmerDetailRq);
                Navigator.pop(context);

                if (farmerDetailRs == null || farmerDetailRs.farmerList == null || farmerDetailRs.farmerList.isEmpty) {
                  throw ValidateException('ไม่พบข้อมูล');
                }

                print('ข้อมูลเกษตรกร ${farmerDetailRs.toJson()}');

                Navigator.pushNamed(context, '/farmer_result', arguments: farmerDetailRs);
              } catch (error, stackTrace) {
                if (error is ValidateException) {
                  DialogUtil.showWarningDialog(context, 'แจ้งเตือน', '${error.message}');
                } else if (error is ErrorWebApiException) {
                  Navigator.pop(context);
                  DialogUtil.showWarningDialog(context, 'แจ้งเตือน', '${error.error}');
                } else {
                  Navigator.pop(context);
                  DialogUtil.showWarningDialog(context, 'แจ้งเตือน', '$error');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
