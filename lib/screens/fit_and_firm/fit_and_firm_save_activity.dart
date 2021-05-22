import 'dart:convert';

import 'package:ASmartApp/constant/constant.dart';
import 'package:ASmartApp/exception/app_exception.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_add_activity_rq.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_add_activity_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_time_duration_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/utils/date_time_util.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/shared_pref_util.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:ASmartApp/themes/theme.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FitAndFirmSaveActivity extends StatefulWidget {
  @override
  _FitAndFirmSaveActivityState createState() => _FitAndFirmSaveActivityState();
}

class _FitAndFirmSaveActivityState extends State<FitAndFirmSaveActivity> {
  FAFActivityTimeDurationRs _activityTimeDurationRs;
  DateTime _startDate;

  DateTime _selectedDate;
  TextEditingController _point;

  // ตัวแปรอ่านไฟล์ในเครื่อง
  File _imageFile;

  @override
  void initState() {
    super.initState();
    loadTimeDuration();
    _selectedDate = DateTime.now();
    _point = TextEditingController()..text = '0';
  }

  void loadTimeDuration() async {
    try {
      _activityTimeDurationRs = FAFActivityTimeDurationRs.fromJson(await SharedPrefUtil.read(SharedPrefKey.FIT_AND_FIRM_TIME_DUTATION));
      _startDate = _activityTimeDurationRs?.fafActivityTimeDurations?.firstWhere((element) => 'regis' == element.activity)?.startDate;
    } catch (error) {
      print('error load shared pref : $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2020, 11), lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // ฟังก์ชันเปิดแกเลอรี่
  _openGallery(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('storeStep', 0);

    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery, maxHeight: 400.0, maxWidth: 400.0);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
    // ปิด popup
    Navigator.of(context).pop();
    await Future.delayed(Duration(milliseconds: 1000));
    preferences.setInt('storeStep', 4);
  }

  // ฟังก์ชันเปิดกล้องถ่ายภาพ
  _openCamera(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('storeStep', 0);

    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
    // ปิด popup
    Navigator.of(context).pop();
    await Future.delayed(Duration(milliseconds: 1000));
    preferences.setInt('storeStep', 4);
  }

  // สร้างหน้าต่าง popup เลือกช่องทางในการดึงรูป
  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('แกลเลอรี'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('กล้องถ่ายรูป'),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกผลการออกกำลังกาย'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    buildActivityDateRow(context),
                    buildActivityPointRow(context),
                  ],
                ),
              ),
              buildUploadImage(context),
              buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivityDateRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                'วันที่ออกกำลังกาย',
                style: Theme.of(context).textTheme.normalGrey,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringUtil.toTruncDateFormat(_selectedDate),
                      ),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityPointRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                'ผลการออกกำลังกาย',
                style: Theme.of(context).textTheme.normalGrey,
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      controller: _point,
                      onTap: () => _point.selection = TextSelection(baseOffset: 0, extentOffset: _point.value.text.length),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
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

  Widget buildUploadImage(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    'รูปภาพ',
                    style: Theme.of(context).textTheme.normalGrey,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: RaisedButton.icon(
                    //elevation: 5.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.orangeAccent,
                    label: Text(
                      'เลือกรูป',
                      style: Theme.of(context).textTheme.normalWhite,
                    ),
                    icon: Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                    onPressed: () => _showBottomSheet(context),
                  ),
                ),
              ],
            ),
            _imageFile == null
                ? SizedBox.shrink()
                : Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)), side: BorderSide(width: 1, color: Colors.grey)),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _imageFile,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: RaisedButton.icon(
          //elevation: 5.0,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.green,
          label: new Text(
            'บันทึกผลการออกกำลังกาย',
            style: Theme.of(context).textTheme.normalWhite,
          ),
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          onPressed: () async {
            try {
              if (_selectedDate.isBefore(_startDate)) {
                throw ValidateException('กรุณาเลือกวันที่ หลังวันที่เริ่มต้นกิจกรรม');
              }

              if (_selectedDate.isAfter(DateTime.now())) {
                throw ValidateException('กรุณาระบุวันที่ ไม่เกินวันปัจจุบัน');
              }

              num p = num.parse(_point.text);
              if (p <= 0) {
                throw ValidateException('กรุณาระบุผลการออกกำลังกายมากกว่า 0');
              }
              if (_imageFile == null) {
                throw ValidateException('กรุณาเลือกภาพถ่ายผลการออกกำลังกาย');
              }

              List<int> imageBytes;
              String imageB64;

              try {
                imageBytes = _imageFile.readAsBytesSync();
                imageB64 = base64Encode(imageBytes);
              } catch (error) {
                throw ValidateException('กรุณาเลือกภาพถ่ายผลการออกกำลังกาย');
              }

              SharedPreferences preferences = await SharedPreferences.getInstance();
              String imei = preferences.getString('storeDeviceIMEI');
              String pass = preferences.getString('pass');

              FAFAddActivityRq fafAddActivityRq = FAFAddActivityRq()
                ..imei = imei
                ..pass = pass
                ..activityDate = StringUtil.toTruncDateFormat(_selectedDate, format: 'yyyy-MM-dd')
                ..activityDistance = _point.text.trim()
                ..activityImage = imageB64;

              DialogUtil.showLoadingDialog(context);
              FAFAddActivityRs fafAddActivityRs = await BaacRestApiService().fafAddActivity(fafAddActivityRq);
              Navigator.pop(context);

              if (fafAddActivityRs == null) {
                throw ValidateException('บันทึกข้อมูลไม่สำเร็จ');
              }
              if (fafAddActivityRs.statusCode != '01') {
                throw ValidateException('${fafAddActivityRs.statusDesc}');
              }
              await DialogUtil.showSuccessDialog(context, fafAddActivityRs.statusDesc ?? '', 'บันทึกข้อมูลการออกกำลังกายเรียบร้อมแล้ว');

              Navigator.pop(context, true);
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
    );
  }
}
