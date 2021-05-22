import 'package:ASmartApp/constant/constant.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_goal_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_sum_detail_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/shared_pref_util.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class FitAndFirmInfo extends StatefulWidget {
  @override
  _FitAndFirmInfoState createState() => _FitAndFirmInfoState();
}

class _FitAndFirmInfoState extends State<FitAndFirmInfo> {
  FAFActivityDetailRs activityDetailRs;
  FAFActivitySumDetailRs activitySumDetailRs;
  FAFActivityGoalRs activityGoalRs;
  FAFActivityGoal fafActivityGoal;
  bool refreshSuccess = true;

  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  void loadConfig() async {
    try {
      activityDetailRs = FAFActivityDetailRs.fromJson(await SharedPrefUtil.read(SharedPrefKey.FIT_AND_FIRM_DETAIL));
      activitySumDetailRs = FAFActivitySumDetailRs.fromJson(await SharedPrefUtil.read(SharedPrefKey.FIT_AND_FIRM_SUM));
      activityGoalRs = FAFActivityGoalRs.fromJson(await SharedPrefUtil.read(SharedPrefKey.FIT_AND_FIRM_GOAL));

      setState(() {});
    } catch (error) {
      print('error load shared pref : $error');
    }
  }


  Future<Null> loadActivityList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String imei = preferences.getString('storeDeviceIMEI');
      String pass = preferences.getString('pass');
      BaacRestApiService service = BaacRestApiService();
      activityDetailRs = await service.fafActivityDetail(imei, pass);
      activitySumDetailRs = await service.fafActivitySumDetail(imei, pass);
      await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_DETAIL, activityDetailRs.toJson());
      await SharedPrefUtil.save(SharedPrefKey.FIT_AND_FIRM_SUM, activityDetailRs.toJson());
      setState(() {
        refreshSuccess = true;
      });
    } catch (error, stackTrace) {
      bool loadAgain = await DialogUtil.showConfirmWarningDialog(context, 'เกิดข้อผิดพลาด', 'เกิดข้อผิดพลาดในการโหลดข้อมูล ต้องการโหลดข้อมูลอีกครั้งหรือไม่');
      setState(() {
        refreshSuccess = false;
      });
      if (loadAgain) {
        loadActivityList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการออกกำลังกายของฉัน'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadActivityList,
          child: refreshSuccess == null || refreshSuccess
              ? ListView(
                  children: [
                    buildCardActivityType(),
                    buildCardActivityProgress(context),
                    // buildCardActivityList(context),
                    buildCardActivityList2(context),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget buildCardActivityType() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
        elevation: 10.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'ประเภทกิจกรรม',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            Text(
              activitySumDetailRs == null
                  ? ''
                  : StringUtil.isNullOrEmpty(activitySumDetailRs.activityDesc)
                      ? ''
                      : activitySumDetailRs.activityDesc,
              style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardActivityProgress(BuildContext context) {
    double distance = 0;
    double distanceGoal = 0;
    double goal10 = 0;
    double goal30 = 0;

    String distanceStr = '';

    String distancePercent = '';
    double distancePercentDouble = 0;
    String activityType = '';

    if (activitySumDetailRs != null) {
      distance = StringUtil.isNullOrEmpty(activitySumDetailRs.distanceSum) ? null : double.parse(activitySumDetailRs.distanceSum);
      distanceStr = distance?.toStringAsFixed(3);
      distanceGoal = StringUtil.isNullOrEmpty(activitySumDetailRs.goal) == null ? null : double.parse(activitySumDetailRs.goal);
      activityType = activitySumDetailRs.activity;
    }
    if (activityGoalRs != null && activityGoalRs.fafActivityGoals != null && activityGoalRs.fafActivityGoals.isNotEmpty) {
      fafActivityGoal = activityGoalRs.fafActivityGoals.firstWhere((element) => element.type == activityType);
      if (fafActivityGoal != null) {
        goal10 = double.parse(fafActivityGoal.goal10);
        goal30 = double.parse(fafActivityGoal.goal30);
        distancePercentDouble = (distance / distanceGoal) * 100;
        distancePercent = '${(distancePercentDouble).toStringAsFixed(3)}';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'ระยะทาง',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  distanceStr ?? '',
                  style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(
                  fafActivityGoal?.unit ?? '',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'จากเป้าหมาย ${activitySumDetailRs?.goal ?? ''} ${fafActivityGoal?.unit ?? ''} ',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 70,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2500,
                    // percent: 0.8,
                    percent: (distancePercentDouble / 100) > 1 ? 1 : distancePercentDouble / 100,
                    center: Text(
                      '$distancePercent %',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (distancePercentDouble < 30)
                    Expanded(
                      child: Text(
                        'คุณพิชิตกิจกรรม $distancePercent% แล้ว พยายามเข้า',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  if (distancePercentDouble >= 30 && distancePercentDouble < 100)
                    Expanded(
                      child: Text(
                        'ยินดีด้วยคุณพิชิตกิจกรรม 30% ได้แล้ว เตรียมรับเสื้อได้เลย ขณะนี้คุณทำได้ $distancePercent% ใกล้ถึงจุดหมายแล้ว',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  if (distancePercentDouble >= 100)
                    Expanded(
                      child: Text(
                        'ยินดีด้วยคุณพิชิตกิจกรรม 100% ได้แล้ว คุณถึงจุดหมายแล้ว',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
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

  Widget buildCardActivityList2(BuildContext context) {
    if (activityDetailRs == null || activityDetailRs.fafActivityDetails == null || activityDetailRs.fafActivityDetails.isEmpty) {
      return SizedBox.shrink();
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    // color: colorPrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.black,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'รายการออกกำลังกาย',
                                      style: TextStyle(fontSize: 18, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.info,
                                  color: Colors.green[700],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  expanded: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: activityDetailRs.fafActivityDetails.length,
                    itemBuilder: (context, index) {
                      // MockActivity item = activityList[index];
                      FAFActivityDetail item = activityDetailRs.fafActivityDetails[index];

                      Widget buildRow(String label, String data) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                label ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                data ?? '',
                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        );
                      }

                      return InkWell(
                        onTap: () {
                          // final dynamic resultArticleSelected = await Navigator.pushNamed(context, RoutePaths.ArticleSelectListGeneric, arguments: articleList);
                          Navigator.pushNamed(context, '/fit_and_firm_info_detail', arguments: item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                          child: Card(
                            color: Colors.green[400],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'ID ${item.id}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.transparent,
                                  ),
                                  buildRow('วันที่ออกกำลังกาย', StringUtil.toTruncDateFormat(item.activityDate, format: 'dd/MM/yyyy')),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  buildRow('ระยะทาง', '${item.distance} ${fafActivityGoal?.unit ?? ''}'),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  buildRow('วันที่บันทึก', StringUtil.toTruncDateFormat(item.createDate, format: 'dd/MM/yyyy')),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
