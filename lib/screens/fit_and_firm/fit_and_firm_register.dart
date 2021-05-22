import 'package:ASmartApp/constant/constant.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_goal_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_register_rq.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_register_rs.dart';
import 'package:ASmartApp/services/baac_rest_api_service.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/shared_pref_util.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

class FitAndFirmRegister extends StatefulWidget {
  @override
  _FitAndFirmRegisterState createState() => _FitAndFirmRegisterState();
}

class _FitAndFirmRegisterState extends State<FitAndFirmRegister> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController telNoController = TextEditingController();

  FAFActivityGoalRs activityGoalRs;

  String activityValue = '';

  String shirtValue = '';
  List<S2Choice<String>> shirtOptions = [
    S2Choice<String>(value: 'SS', title: 'SS'),
    S2Choice<String>(value: 'S', title: 'S'),
    S2Choice<String>(value: 'M', title: 'M'),
    S2Choice<String>(value: 'L', title: 'L'),
    S2Choice<String>(value: 'XL', title: 'XL'),
    S2Choice<String>(value: 'XXL', title: 'XXL'),
  ];

  @override
  void initState() {
    super.initState();
    loadActivityGoal();
  }

  void loadActivityGoal() async {
    try {
      activityGoalRs = FAFActivityGoalRs.fromJson(await SharedPrefUtil.read(SharedPrefKey.FIT_AND_FIRM_GOAL));
      setState(() {});
    } catch (error) {
      print('error load shared pref : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดรายการออกกำลังกาย'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: ListView(
            children: [
              buildCardInput(),
              // buildCardShirtDesc(),
              buildCardRemark(),
              buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          children: [
            buildTextEdit(Icons.line_weight, 'น้ำหนัก', weightController),
            buildTextEdit(Icons.height, 'ส่วนสูง', heightController),
            buildTextEdit(Icons.phone_android, 'หมายเลขโทรศัพท์', telNoController),
            buildSmartSelectActivityType(),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SmartSelect<String>.single(
                title: 'ขนาดเสื้อ',
                value: shirtValue,
                choiceItems: shirtOptions,
                modalType: S2ModalType.popupDialog,
                onChange: (state) => setState(() => shirtValue = state.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextEdit(IconData iconData, String hintText, TextEditingController textEditingController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: hintText ?? '',
              hintText: hintText ?? '',
              icon: Icon(
                iconData,
              ),
              suffixIcon: Visibility(
                visible: textEditingController.text.length > 0,
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      textEditingController.clear();
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
    );
  }

  Widget buildSmartSelectActivityType() {
    if (activityGoalRs == null || activityGoalRs.fafActivityGoals == null) {
      return CircularProgressIndicator();
    }

    List<S2Choice<String>> activityOptions = [];
    activityGoalRs.fafActivityGoals.forEach((element) {
      activityOptions.add(S2Choice<String>(value: element.type, title: element.activityDesc));
    });

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SmartSelect<String>.single(
        title: 'ประเภทกิจกรรม',
        value: activityValue,
        choiceItems: activityOptions,
        modalType: S2ModalType.bottomSheet,
        onChange: (state) => setState(() => activityValue = state.value),
      ),
    );
  }

  Widget buildCardShirtDesc() {}

  Widget buildCardRemark() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'กรุณาตรวจสอบข้อมูลให้ถูกต้องก่อนสมัคร ธนาคารขอสงวนสิทธิ์ในการเปลี่ยนแปลงขนาดเสื้อ',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget buildRegisterButton() {
    return RaisedButton(
      //elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.green,
      child: Text(
        'สมัคร',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        if (StringUtil.isNullOrEmpty(weightController.text)) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุน้ำหนัก');
          return;
        }
        if (StringUtil.isNullOrEmpty(heightController.text)) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุส่วนสูง');
          return;
        }
        if (StringUtil.isNullOrEmpty(telNoController.text)) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุหมายเลขโทรศัพท์');
          return;
        }
        if (telNoController.text.length != 10) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุหมายเลขโทรศัพท์ให้ครบ 10 หลัก');
          return;
        }
        if (StringUtil.isNullOrEmpty(activityValue)) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุประเภทกิจกรรม');
          return;
        }
        if (StringUtil.isNullOrEmpty(shirtValue)) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'กรุณาระบุขนาดเสื้อ');
          return;
        }

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String imei = preferences.getString('storeDeviceIMEI');
        String pass = preferences.getString('pass');

        FAFRegisterRq fafRegisterRq = FAFRegisterRq()
          ..imei = imei
          ..pass = pass
          ..height = heightController.text.trim()
          ..weight = weightController.text.trim()
          ..activityType = activityValue
          ..telNo = telNoController.text.trim()
          ..shirtSize = shirtValue;

        FAFRegisterRs fafRegisterRs = await BaacRestApiService().fafRegister(fafRegisterRq);

        if (fafRegisterRs == null) {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', 'บันทึกข้อมูลไม่สำเร็จ');
          return;
        }
        if (fafRegisterRs.statusCode != '01') {
          DialogUtil.showWarningDialog(context, 'แจ้งเตือน', fafRegisterRs.statusDesc);
          return;
        }

        await DialogUtil.showSuccessDialog(context, fafRegisterRs.statusDesc ?? '', 'บันทึกข้อมูลการสมัครเรียบร้อมแล้ว');
        Navigator.pop(context, true);
      },
    );
  }
}
