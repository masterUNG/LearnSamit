import 'package:ASmartApp/constant/constant.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_attachment_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_goal_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_sum_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_check_register_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_time_duration_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:ASmartApp/utils/shared_pref_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FitAndFirmHome extends StatefulWidget {
  @override
  _FitAndFirmHomeState createState() => _FitAndFirmHomeState();
}

class _FitAndFirmHomeState extends State<FitAndFirmHome> {
  FAFActivityTimeDurationRs _activityTimeDurationRs;
  FAFActivityDetailRs fafActivityDetailRs;
  FAFActivitySumDetailRs fafActivitySumDetailRs;
  FAFCheckRegisterRs fafCheckRegisterRs;

  bool _loadFafConfigSuccess = false;

  Future<Null> readFafConfig() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String imei = preferences.getString('storeDeviceIMEI');
      String pass = preferences.getString('pass');
      BaacRestApiService service = BaacRestApiService();

      var timeDurationTask = service.fafActivityTimeDurations(imei, pass);
      var activityGoalTask = service.fafActivityGoals(imei, pass);
      // var activityAttachmentTask = service.fafActivityAttachment(imei, pass);
      var checkRegisterTask = service.fafCheckRegister(imei, pass);

      await Future.delayed(Duration(milliseconds: 5000));
      await Future.wait([
        timeDurationTask,
        activityGoalTask,
        // activityAttachmentTask,
        checkRegisterTask,

        // activityDetailListTask,
        // activitySumDetailTask,
      ]);
      _activityTimeDurationRs = await timeDurationTask;
      FAFActivityGoalRs activityGoalRs = await activityGoalTask;
      // FAFActivityAttachmentRs fafActivityAttachmentRs = await activityAttachmentTask;
      fafCheckRegisterRs = await checkRegisterTask;

      await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_TIME_DUTATION, _activityTimeDurationRs.toJson());
      await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_GOAL, activityGoalRs.toJson());
      // await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_ATTACHMENT, fafActivityAttachmentRs.toJson());

      if (fafCheckRegisterRs == null || fafCheckRegisterRs.fafCheckRegisters == null || fafCheckRegisterRs.fafCheckRegisters.isEmpty || fafCheckRegisterRs.fafCheckRegisters[0].statusCode == '01') {
        try {
          var activityDetailListTask = service.fafActivityDetail(imei, pass);
          var activitySumDetailTask = service.fafActivitySumDetail(imei, pass);
          await Future.wait([
            activityDetailListTask,
            activitySumDetailTask,
          ]);

          fafActivityDetailRs = await activityDetailListTask;
          fafActivitySumDetailRs = await activitySumDetailTask;
          await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_DETAIL, fafActivityDetailRs.toJson());
          await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_SUM, fafActivitySumDetailRs.toJson());
        } catch (error, stackTrace) {
          print(error);
        }
      }

      setState(() {
        _loadFafConfigSuccess = true;
      });
    } catch (error, stackTrace) {
      await DialogUtil.showWarningDialog(context, 'เกิดข้อผิดพลาด', 'เกิดข้อผิดพลาดในการโหลดข้อมูล');
      setState(() {
        _loadFafConfigSuccess = false;
      });
      readFafConfig();
    }
  }

  @override
  void initState() {
    super.initState();
    readFafConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fit and Firm'),
        ),
        body: _loadFafConfigSuccess
            ? RefreshIndicator(
                onRefresh: readFafConfig,
                child: ListView(
                  children: [
                    buildGreenButton(
                      Icons.save,
                      'บันทึกผลการออกกำลังกาย',
                      () async {
                        if (fafCheckRegisterRs == null || fafCheckRegisterRs.fafCheckRegisters == null || fafCheckRegisterRs.fafCheckRegisters.isEmpty) {
                          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'ไม่พบข้อมูล เกิดข้อผิดพลาดในการดึงข้อมูลสถานะการสมัคร');
                          return;
                        }
                        if (fafCheckRegisterRs.fafCheckRegisters[0].statusCode != '01') {
                          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'คุณยังไม่ได้ลงทะเบียน ไม่สามารถบันทึกผลกิจกรรมได้');
                          return;
                        }
                        dynamic saveResult = await Navigator.pushNamed(context, '/fit_and_frim_save_activity');
                        if (saveResult == null) {
                          return;
                        }
                        bool saveSuccess = saveResult as bool;
                        if (saveSuccess) {
                          setState(() {
                            _loadFafConfigSuccess = false;
                          });
                          readFafConfig();
                        }
                      },
                    ),
                    buildGreenButton(
                      Icons.info,
                      'การออกกำลังกายของฉัน',
                      () {
                        if (fafActivityDetailRs == null) {
                          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'ไม่พบข้อมูล ผลกิจกรรม');
                          return;
                        }
                        Navigator.pushNamed(context, '/fit_and_firm_info');
                      },
                      buttonColorLevel: 400,
                    ),
                    buildGreenButton(
                      Icons.rule,
                      'รายละเอียดภารกิจ',
                      () {
                        Navigator.pushNamed(context, '/fit_and_firm_goal');
                      },
                    ),
                    buildGreenButton(
                      Icons.app_registration,
                      'สมัครเลย',
                      () async {
                        if (fafCheckRegisterRs == null || fafCheckRegisterRs.fafCheckRegisters == null || fafCheckRegisterRs.fafCheckRegisters.isEmpty) {
                          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'ไม่พบข้อมูล เกิดข้อผิดพลาดในการดึงข้อมูลสถานะการสมัคร');
                          return;
                        }
                        if (fafCheckRegisterRs.fafCheckRegisters[0].statusCode == '01') {
                          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'คุณลงทะเบียนแล้ว ไม่สามารถลงทะเบียนกิจกรรมได้');
                          return;
                        }
                        dynamic registerResult = await Navigator.pushNamed(context, '/fit_and_firm_register');
                        if (registerResult == null) {
                          return;
                        }
                        bool registerSuccess = registerResult as bool;
                        if (registerSuccess) {
                          setState(() {
                            _loadFafConfigSuccess = false;
                          });
                          readFafConfig();
                        }
                      },
                      buttonColorLevel: 400,
                    ),
                  ],
                ),
              )
            : MyStyle().showProgress());
  }

  Widget buildGreenButton(IconData iconData, String text, final GestureTapCallback tapCallback, {int buttonColorLevel}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: Card(
        color: Colors.green[buttonColorLevel ?? 600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 4.0,
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.green[50],
          ),
          title: Text(
            text ?? '',
            style: TextStyle(color: Colors.white),
          ),
          onTap: tapCallback,
        ),
      ),
    );
  }
}
