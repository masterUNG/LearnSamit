import 'package:ASmartApp/models/fund_loan_model.dart';
import 'package:ASmartApp/models/funddetail_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ASmartApp/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundLoanScreen extends StatefulWidget {
  FundLoanScreen({Key key}) : super(key: key);

  @override
  _FundLoanScreenState createState() => _FundLoanScreenState();
}

class _FundLoanScreenState extends State<FundLoanScreen> {
  Map<String, dynamic> mapImeiPass = Map();

  List<FundLoanModel> fundLoans = [];
  List<FundDetailModel> fundDetailModels = List();

  @override
  void initState() {
    super.initState();
    readFundDetail();
    readFundLoan();
  }

  Future<Null> readFundLoan() async {
    setState(() {
      fundLoans.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    var result = await CallAPI().postData(mapImeiPass, 'FundLoan/');
    for (var json in result) {
      FundLoanModel model = FundLoanModel.fromJson(json);
      setState(() {
        fundLoans.add(model);
      });
    }
  }

  Future<Null> readFundDetail() async {
    setState(() {
      fundDetailModels.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mapImeiPass['IMEI'] = preferences.getString('storeDeviceIMEI');
    mapImeiPass['pass'] = preferences.getString('pass');

    var result = await CallAPI().postData(mapImeiPass, 'FundDetail/');
    for (var json in result) {
      FundDetailModel model = FundDetailModel.fromJson(json);
      setState(() {
        fundDetailModels.add(model);
      });
    }
  }

  Future<Null> refreshData() async {
    readFundLoan();
    readFundDetail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (fundLoans.isEmpty) && (fundDetailModels.isEmpty)
          ? MyStyle().showProgress()
          : RefreshIndicator(
              child: ListView(
                children: [
                  buildCardContractInfo(context),
                  buildCardContractStatus(context),
                ],
              ),
        onRefresh: refreshData,
      ),
    );
  }

  Widget buildCardContractStatus(BuildContext context) {
    if (fundLoans == null || fundLoans.isEmpty) {
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
                    color: MyStyle().primaryColor,
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
                                      'ข้อมูลสถานะสัญญา',
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
                  expanded: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 1),
                    itemCount: fundLoans == null ? 0 : fundLoans.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.article,
                          color: Colors.black,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'เลขที่สัญญา : ',
                              style: Theme.of(context).textTheme.smallBlack,
                            ),
                            Expanded(
                              child: Text(
                                fundLoans[index].contractNo,
                                style: Theme.of(context).textTheme.smallBlack,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'วงเงินกู้ : ',
                                  style: Theme.of(context).textTheme.smallBlack,
                                ),
                                Expanded(
                                  child: Text(
                                    MyStyle().formatAmount(fundLoans[index].loanAmount) + ' บาท',
                                    style: Theme.of(context).textTheme.smallBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'สถานะสัญญา :',
                                  style: Theme.of(context).textTheme.smallerBlack,
                                ),
                                Expanded(
                                  child: Text(
                                    fundLoans[index].stateName,
                                    style: Theme.of(context).textTheme.smallerBlack,
                                  ),
                                ),
                              ],
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

  Widget buildCardContractInfo(BuildContext context) {
    if (fundDetailModels == null || fundDetailModels.isEmpty) {
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
                    color: MyStyle().weakColor,
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
                                      'ข้อมูลสัญญา',
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
                    itemCount: fundDetailModels == null ? 0 : fundDetailModels.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        leading: Icon(Icons.account_balance),
                        title: Text(
                          'เลขที่สัญญา : ${fundDetailModels[index]?.contractNo}',
                          style: Theme.of(context).textTheme.smallBlack,
                        ),
                        subtitle: Text(
                          'หนี้คงเหลือ : ${StringUtil.toFormatAmount(fundDetailModels[index]?.debtBalance)} บาท',
                          style: Theme.of(context).textTheme.smallBlack,
                        ),
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        'เลขที่สัญญา :',
                                        style: Theme.of(context).textTheme.smallGrey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        fundDetailModels[index]?.contractNo,
                                        style: Theme.of(context).textTheme.smallBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        'วงเงินกู้ :',
                                        style: Theme.of(context).textTheme.smallGrey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        '${StringUtil.toFormatAmount(fundDetailModels[index]?.loanAmount)} บาท',
                                        style: Theme.of(context).textTheme.smallBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        'งวดชำระ :',
                                        style: Theme.of(context).textTheme.smallGrey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        StringUtil.toFormatAmount(fundDetailModels[index]?.receiveMaxtime),
                                        style: Theme.of(context).textTheme.smallBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        'ยอดชำระต่องวด :',
                                        style: Theme.of(context).textTheme.smallGrey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        '${StringUtil.toFormatAmount(fundDetailModels[index]?.payPerPeriod)} บาท',
                                        style: Theme.of(context).textTheme.smallBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        'ยอดคงเหลือ :',
                                        style: Theme.of(context).textTheme.smallGrey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        '${StringUtil.toFormatAmount(fundDetailModels[index]?.debtBalance)} บาท',
                                        style: Theme.of(context).textTheme.smallBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
