import 'package:ASmartApp/models/benefit_model.dart';
import 'package:ASmartApp/models/emp_value_model.dart';
import 'package:ASmartApp/models/pf_policy_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ASmartApp/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BenefitScreen extends StatefulWidget {
  BenefitScreen({Key key}) : super(key: key);

  @override
  _BenefitScreenState createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen> {
  Map<String, dynamic> mapImeiPass = Map();

  PfPolicyModel pfPolicyModel;
  EmpPFValueModel empPFValueModel;
  List<BenefitModel> benefitModels = List();

  @override
  void initState() {
    super.initState();

    readBenefit();
    readEmpPFPolicy();
    readEmpPFValue();
  }

  Future<Null> readBenefit() async {
    setState(() {
      benefitModels.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    String url = 'benefits';
    var result = await CallAPI().postData(mapImeiPass, url);
    for (var json in result) {
      BenefitModel model = BenefitModel.fromJson(json);
      setState(() {
        benefitModels.add(model);
      });
    }
  }

  Future<Null> readEmpPFPolicy() async {
    setState(() {
      pfPolicyModel = null;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    String url = 'EmpPFPolicy';
    var result = await CallAPI().postData(mapImeiPass, url);
    for (var json in result) {
      setState(() {
        pfPolicyModel = PfPolicyModel.fromJson(json);
      });
    }
  }

  Future<Null> readEmpPFValue() async {
    setState(() {
      empPFValueModel = null;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    String url = 'EmpPFValue';
    var result = await CallAPI().postData(mapImeiPass, url);
    for (var json in result) {
      setState(() {
        empPFValueModel = EmpPFValueModel.fromJson(json);
      });
    }
  }

  Future<Null> refreshData() async {
    readBenefit();
    readEmpPFPolicy();
    readEmpPFValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (benefitModels.isEmpty) && (pfPolicyModel == null) && (empPFValueModel == null)
          ? MyStyle().showProgress()
          : RefreshIndicator(
              child: ListView(
                children: [
                  buildCardBenefit(context),
                  buildCardPolicy(context),
                  buildCardEmpValue(context),
                ],
              ),
              onRefresh: refreshData,
            ),
    );
  }

  Widget buildCardEmpValue(BuildContext context) {
    if (empPFValueModel == null) {
      return SizedBox.shrink();
    }
    return ExpandableNotifier(
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
                  color: Color(0xff4b830d),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'ผลตอบแทนการลงทุน',
                                    style: Theme.of(context).textTheme.largeWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.keyboard_arrow_down,
                            collapseIcon: Icons.keyboard_arrow_up,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'รหัสพนักงาน : ${empPFValueModel?.eMPLOYEEID ?? ''}',
                            style: Theme.of(context).textTheme.smallBlack,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'ข้อมูล ณ วันที่ : ${empPFValueModel?.nAVDATE ?? ''}',
                            style: Theme.of(context).textTheme.smallBlack,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'นโยบาย : ${empPFValueModel?.pLANCODE ?? ''}',
                            style: Theme.of(context).textTheme.smallBlack,
                          ),
                        ],
                      ),
                      buildCardEmpValueData(
                        'มูลค่าหน่วยลงทุน',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.nUNITFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.nUNITFUND2,
                        'หน่วย',
                      ),
                      buildCardEmpValueData(
                        'ส่วนของสมาชิกเงินสะสม',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.cONTEFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.cONTEFUND2,
                        'บาท',
                      ),
                      buildCardEmpValueData(
                        'ส่วนของสมาชิกผลประโยชน์',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.eARNEFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.eARNEFUND2,
                        'บาท',
                      ),
                      buildCardEmpValueData(
                        'ส่วนของนายจ้างเงินสมทบ',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.cONTCFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.cONTCFUND2,
                        'บาท',
                      ),
                      buildCardEmpValueData(
                        'ส่วนของนายจ้างผลประโยชน์',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.eARNCFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.eARNCFUND2,
                        'บาท',
                      ),
                      buildCardEmpValueData(
                        'จำนวนเงินรวม',
                        empPFValueModel?.cOMPANYFUND1,
                        empPFValueModel?.tOTALFUND1,
                        empPFValueModel?.cOMPANYFUND2,
                        empPFValueModel?.tOTALFUND2,
                        'บาท',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'ผลประโยชน์การลงทุน : ',
                              style: Theme.of(context).textTheme.boldBlack,
                            ),
                            Expanded(
                              child: Text(
                                '${empPFValueModel?.tOTALFUND1FUND2 ?? ''} บาท',
                                style: Theme.of(context).textTheme.boldRed,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardEmpValueData(String header, String label1, String value1, String label2, String value2, String unit) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                header ?? '',
                style: Theme.of(context).textTheme.boldBlack,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  'บริษัทจัดการ  ${label1 ?? ''}   ',
                  style: Theme.of(context).textTheme.smallGrey,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  '${value1 ?? ''}  ${unit ?? ''}',
                  style: Theme.of(context).textTheme.smallBlack,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  'บริษัทจัดการ  ${label2 ?? ''}',
                  style: Theme.of(context).textTheme.smallGrey,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  '${value2 ?? ''}  ${unit ?? ''}',
                  style: Theme.of(context).textTheme.smallBlack,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCardPolicy(BuildContext context) {
    if (pfPolicyModel == null) {
      return SizedBox.shrink();
    }

    return ExpandableNotifier(
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
                  color: Color(0xff7cb342), // color: colorPrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'นโยบายการลงทุน',
                                    style: Theme.of(context).textTheme.largeBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.keyboard_arrow_down,
                            collapseIcon: Icons.keyboard_arrow_up,
                            iconColor: Colors.black,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildCardPolicyData('รหัสพนักงาน', pfPolicyModel?.eMPLOYEEID ?? ''),
                      buildCardPolicyData('ลำดับที่นโยบาย', pfPolicyModel?.pOLICY ?? ''),
                      buildCardPolicyData('จำนวนกองทุนตราสารหนี', pfPolicyModel?.iNSTRUMENTPERCENT ?? ''),
                      buildCardPolicyData('จำนวนกองทุดตราสารทุน', pfPolicyModel?.eQUITYPERCENT ?? ''),
                      buildCardPolicyData('อัดตราสมทบลูกจ่้าง', pfPolicyModel?.eMPCONTRIBUTEPERCENT ?? ''),
                      buildCardPolicyData('อัดตราสมทบนายจ้าง', pfPolicyModel?.cOMPANYCONTRIBUTEPERCENT ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardPolicyData(String label, String data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                '$label :',
                style: Theme.of(context).textTheme.smallBlack,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                data,
                style: Theme.of(context).textTheme.smallBlack,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget buildCardBenefit(BuildContext context) {
    if (benefitModels == null || benefitModels.isEmpty) {
      return SizedBox.shrink();
    }

    return ExpandableNotifier(
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
                    color: Color(0xffaee571),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'สวัสดิการ',
                                      style: Theme.of(context).textTheme.largeBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.keyboard_arrow_down,
                              collapseIcon: Icons.keyboard_arrow_up,
                              iconColor: Colors.black,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  expanded: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 1),
                    itemCount: benefitModels == null ? 0 : benefitModels.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.payment,
                          size: 24,
                        ),
                        title: Text(
                          benefitModels[index].listName,
                          style: Theme.of(context).textTheme.smallBlack,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  MyStyle().formatAmount(benefitModels[index].amount),
                                  style: Theme.of(context).textTheme.largeBoldRed,
                                ),
                                Text(
                                  ' บาท',
                                  style: Theme.of(context).textTheme.smallGrey,
                                ),
                              ],
                            ),
                            Text(
                              'วันที่ : ' + benefitModels[index].postDate,
                              style: Theme.of(context).textTheme.smallBlack,
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
