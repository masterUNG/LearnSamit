import 'package:ASmartApp/models/register_model.dart';
import 'package:ASmartApp/screens/onboarding/onboarding_screen.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/dialog_util.dart';
import 'package:ASmartApp/utils/normal_dialog.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ASmartApp/themes/theme.dart';

class ConsentScreen extends StatefulWidget {
  final Map<String, dynamic> registerRq;

  ConsentScreen(this.registerRq);

  @override
  _ConsentScreenState createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // กดย้อนกลับ
            }),
        title: Text('ข้อตกลงและเงื่อนไข'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ข้อกำหนดและเงื่อนไขการใช้บริการ BAAC Mobile Application for Employee (BAAC Astaffs ) ',
                        style: Theme.of(context).textTheme.smallBoldBlack,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '   ผู้ขอใช้บริการตกลงใช้บริการ BAAC Mobile Application for Employee (BAAC Astaffs ) และตกลงผูกพันตามข้อกำหนดและเงื่อนไข ดังต่อไปนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  '1. คำนิยาม',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   1.1 ธนาคาร หมายถึง ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร (ธ.ก.ส.)',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   1.2 ผู้ขอใช้บริการ หมายถึง พนักงาน และผู้ช่วยพนักงานประเภทที่ 1 ของ ธ.ก.ส. ที่สมัครใช้งานตามที่ธนาคารกำหนดเท่านั้น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   1.3 ข้อมูลส่วนบุคคล หมายถึง ข้อมูลเกี่ยวกับบุคคลซึ่งทำให้สามารถระบุตัวบุคคลนั้นได้ไม่ว่าทางตรงหรือทางอ้อม เช่น ชื่อ–สกุล  ที่อยู่  หมายเลขประจำตัวประชาชน หมายเลขโทรศัพท์เคลื่อนที่ วันเดือนปีเกิด อีเมล์ เป็นต้น ข้อมูลทางชีวภาพ เช่น ลายนิ้วมือ ใบหน้า เป็นต้น ข้อมูลทางการเงิน และ/หรือ ข้อมูลใดๆของผู้ขอใช้บริการที่ให้ไว้แก่ธนาคาร หรือที่ธนาคารได้รับ หรือเข้าถึงได้จากแหล่งอื่น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   1.4 BAAC Astaffs หมายถึง แอปพลิเคชันที่ธนาคารให้บริการตรวจสอบข้อมูลส่วนตัว ข้อมูลสวัสดิการ ข้อมูลกองทุนกู้ยืมเพื่อสวัสดิการพนักงาน ข้อมูลกองทุนสำรองเลี้ยงชีพ ข้อมูลการลงเวลาการปฏิบัติงาน ข้อมูลรายงานการลา ข้อมูลเส้นทางโรงพยาบาลที่ผู้จัดการกำหนด ข้อมูลโครงการ BAAC fit & firm ของผู้ขอใช้บริการ โดยผู้ขอใช้บริการต้องดาวน์โหลดแอปพลิเคชันดังกล่าว ผ่านโทรศัพท์เคลื่อนที่ หรือตามช่องทางที่ธนาคารกำหนดเท่านั้น  เพื่ออำนวยความสะดวกสบายแก่ผู้ขอใช้บริการ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   1.5 รหัสประจำตัวผู้ขอใช้บริการ หรือ User Login หรือ Username หมายถึง รหัสประจำตัวที่ธนาคารกำหนดขึ้นและมอบให้แก่ผู้ใช้บริการ BAAC Astaffsโดยกำหนดรหัสประจำตัวผู้ขอใช้บริการด้วยรหัสประจำตัวพนักงานในการลงทะเบียนเพื่อสมัครเข้าใช้งานบริการนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   1.6 รหัสลับส่วนตัว หมายถึง รหัสเข้าใช้งาน (Mobile PIN) ที่ผู้ขอใช้บริการกำหนดขึ้น เพื่อเป็นรหัสผ่านในการใช้บริการผ่านแอปพลิเคชัน BAAC Astaffs  และหมายความรวมถึงรหัส OTP (One-time password) เพื่อใช้ในการตั้ง Mobile PIN หรือการยืนยันตัวตนเมื่อผู้ขอใช้บริการต้องการเปลี่ยนอุปกรณ์ในการใช้บริการ หรือลืมรหัสลับส่วนตัว',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   1.7 Touch ID/Face Detection หมายถึง การใช้เซ็นเซอร์ของโทรศัพท์เคลื่อนที่ และ/หรือแท็บเล็ต ของผู้ขอใช้บริการในการตรวจสอบลายนิ้วมือ และ/หรือใบหน้าของผู้ขอใช้บริการเพื่อพิสูจน์ตัวตนแทนการระบุ Mobile PIN',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '2. การใช้และการเก็บรักษา ข้อมูลส่วนบุคคล รหัสประจำตัวผู้ขอใช้บริการ',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   2.1 ผู้ขอใช้บริการ ต้องตั้งรหัสลับส่วนตัว (Mobile PIN) เป็นตัวเลข (0-9) จำนวน 6 ตัว ที่มีความซับซ้อน คาดเดายาก โดยไม่ตั้งหมายเลขซ้ำหรือเรียง เช่น 111111 123456 เป็นต้น และไม่ตั้งรหัสผ่านซ้ำกับ 3 ครั้งล่าสุด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   2.2 ผู้ขอใช้บริการจะต้องรักษารหัสลับส่วนตัว และข้อมูลส่วนบุคคล ไว้เป็นความลับและไม่เปิดเผยหรือกระทำการใดๆ ที่ทำให้ผู้อื่นทราบหากมีบุคคลอื่นล่วงรู้รหัสประจำตัวผู้ขอใช้บริการ และ/หรือรหัสลับส่วนตัวของผู้ขอใช้บริการ ผู้ขอใช้บริการต้องเปลี่ยนรหัสดังกล่าวตามวิธีที่ธนาคารกำหนดทันที  และในกรณีที่มีผู้ล่วงรู้รหัส OTP ผู้ขอใช้บริการต้องแจ้งยกเลิก โดยขอรหัส OTP ใหม่ตามวิธีการที่ธนาคารกำหนดทันที',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   2.3 ผู้ขอใช้บริการต้องเก็บรักษาเครื่องมือสื่อสาร (โทรศัพท์เคลื่อนที่ และ/หรือแท็บเล็ต และ/หรือเครื่องมืออื่นใดตามที่ธนาคารกำหนด) สำหรับการทำรายการไว้เป็นอย่างดีในที่ปลอดภัย โดยไม่ตกอยู่ภายใต้การครอบครองของบุคคลอื่น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   2.4 การเข้าใช้บริการ BAAC Astaffs  ผู้ขอใช้บริการต้องใส่รหัสประจำตัวพนักงาน และรหัสบัตรประจำตัวประชาชน ให้ถูกต้องพร้อมปฏิบัติตามขั้นตอน วิธีการและเงื่อนไขการใช้บริการอย่างถูกต้องครบถ้วน และหากใส่รหัสประจำตัวพนักงาน และรหัสบัตรประจำตัวประชาชนไม่ถูกต้องเกินจำนวนครั้งที่ธนาคารกำหนด ระบบจะระงับการให้บริการชั่วคราว โดยให้ผู้ขอใช้บริการดำเนินการลงทะเบียนใหม่ และระบบจะส่งรหัส OTP (One-time password) ทางอีเมล์ที่ผู้ขอใช้บริการลงทะเบียนไว้ โดยผู้ขอใช้บริการต้องใส่รหัสลับส่วนตัวให้ถูกต้องครบถ้วนทุกครั้ง และหากใส่รหัสลับส่วนตัวไม่ถูกต้องเกินจำนวน 3 ครั้ง ระบบจะระงับการให้บริการชั่วคราว',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   2.5 ผู้ขอใช้บริการสามารถกำหนดค่าในเครื่องโทรศัพท์เคลื่อนที่ให้ยินยอมเปิดเผยพิกัด ในการทำรายการ เพื่อประโยชน์ของผู้ขอใช้บริการ BAAC Astaffs  ในด้านความปลอดภัย และยินยอมให้ธนาคารนำเสนอเกี่ยวกับผลิตภัณฑ์บริการ และข้อเสนอพิเศษอื่นๆ จากธนาคารให้แก่ผู้ขอใช้บริการ และ/หรือ เพื่อการอื่นได้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '3. การเข้าใช้บริการ BAAC Astaffs  ของธนาคาร',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   3.1 ธนาคารเปิดให้บริการ BAAC Astaffs  สำหรับพนักงาน และผู้ช่วยพนักงานประเภทที่ 1 ของ ธ.ก.ส. เท่านั้น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.2 ผู้ขอใช้บริการสามารถลงทะเบียนการใช้บริการ BAAC Astaffs  ได้ด้วยตนเอง ผ่านช่องทางแอปพลิเคชัน BAAC Astaffs หรือตามช่องทางที่ธนาคารกำหนด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.3 ผู้ขอใช้บริการยอมรับและตกลงจะปฏิบัติตามระเบียบ และคู่มือวิธีปฏิบัติการใช้บริการที่ธนาคารได้จัดให้ในลักษณะที่ธนาคารเห็นสมควร ซึ่งระเบียบและคู่มือวิธีปฏิบัติดังกล่าวถือเป็นส่วนหนึ่งของข้อตกลงนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.4 ผู้ขอใช้บริการสามารถใช้บริการ BAAC Astaffs  ได้ เมื่อผู้ขอใช้บริการได้จัดทำข้อตกลงการใช้บริการ และ/หรือ ดำเนินการใดๆ ตามที่ธนาคารกำหนด รวมทั้งได้รับอนุมัติจากธนาคารให้เป็นผู้ใช้บริการ BAAC Astaffs  ด้วย โดยผู้ขอใช้บริการต้องผูกพันและปฏิบัติตามข้อกำหนดและเงื่อนไขการใช้บริการที่ธนาคารกำหนด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.5 ผู้ขอใช้บริการต้องมีโทรศัพท์เคลื่อนที่ และ/หรือแท็บเล็ต และ/หรือเครื่องมืออื่นใดตามที่ธนาคารกำหนด ในเครือข่ายระบบ AIS, dtac, TrueMove,TrueMove H, TOT และ CAT ทั้งแบบระบบเติมเงิน (Pre-paid) หรือระบบจ่ายรายเดือน (Post-paid) หรือเครือข่ายที่จะเกิดขึ้นต่อไปในอนาคต โดยการสมัครจะมีผลสมบูรณ์ เมื่อผู้ขอใช้บริการลงทะเบียนการใช้บริการได้ครบถ้วน',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.6 ผู้ขอใช้บริการยอมรับและตกลงว่าการใช้บริการใดๆ ที่กระทำโดยใช้ (1) รหัสประจำตัวผู้ขอใช้บริการและรหัสลับส่วนตัว หรือ (2) Touch ID/Face Detection หรือ (3) วิธีการอื่นใดตามที่ธนาคารกำหนด ตามขั้นตอนและเงื่อนไขสำหรับการใช้บริการประเภทนั้นๆ ให้ถือว่าเป็นการกระทำของผู้ขอใช้บริการเอง และมีผลผูกพันต่อผู้ขอใช้บริการ โดยผู้ขอใช้บริการไม่ต้องลงนามในเอกสารใดๆ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   3.7 ผู้ขอใช้บริการยินยอมชำระค่าธรรมเนียมการเชื่อมต่ออินเตอร์เน็ต จากการใช้บริการ BAAC A-Staffs นอกเหนือจากการใช้บริการโทรศัพท์เคลื่อนที่ปกติ (AirTime) โดยกรณีที่เป็นโทรศัพท์เคลื่อนที่แบบจ่ายรายเดือน (Post-paid) ผู้ขอใช้บริการสามารถตรวจสอบค่าธรรมเนียมได้จากใบแจ้งหนี้ (Statement) ของผู้ให้บริการเครือข่ายโทรศัพท์เคลื่อนที่ ส่วนกรณีโทรศัพท์เคลื่อนที่แบบเติมเงิน (Pre-paid) ผู้ขอใช้บริการสามารถตรวจสอบยอดค่าธรรมเนียมได้จากผู้ให้บริการเครือข่ายโทรศัพท์เคลื่อนที่',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '4. การให้บริการ BAAC Astaffs',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   ในการใช้บริการนี้  ผู้ขอใช้บริการยินยอมให้ธนาคารตรวจสอบข้อมูลที่เกี่ยวข้อง ติดต่อสอบถาม เก็บ รวบรวมใช้ หรือใช้ข้อมูลบางประการหรือทั้งหมด ยินยอมให้ธนาคารเปิดเผยข้อมูลได้ตามความจำเป็นและเหมาะสม หรือเห็นว่าเป็นประโยชน์แก่ผู้ขอใช้บริการในการได้รับข้อเสนอเกี่ยวกับบริการต่างๆ ของธนาคาร ดังนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.1 ข้อมูลส่วนบุคคล ประกอบด้วย ชื่อ-สกุล รหัสพนักงาน เพศ ตำแหน่ง สังกัด เงินเดือน วันเกิด อีเมล์ เบอร์โทรศัพท์ ที่อยู่ IME Mac address',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.2 ข้อมูลเบิกค่าใช้จ่าย ประกอบด้วย',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       4.2.1 ค่าใช้จ่ายประโยชน์เพิ่ม',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าโทรศัพท์มือถือ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าเช่าบ้าน',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าเช่าซื้อและผ่อนชำระ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าเล่าเรียนบุตร',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่ารักษาพยาบาล',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่ารับรองประจำตำแหน่ง',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - เงินช่วยเหลือค่าอาหาร',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       4.2.2 ค่าใช้จ่ายในการเดินทาง',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าเช่าที่พัก',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าเบี้ยเลี้ยง',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าพาหนะ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าน้ำมันเชื้อเพลิง',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - ค่าใช้จ่ายเบ็ดเตล็ด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.3 ข้อมูลกองทุนสำรองเลี้ยงชีพ ประกอบด้วย นโยบายการลงทุน ผลตอบแทนการลงทุน',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.4 กองทุนกู้ยืมเพื่อสวัสดิการพนักงาน ประกอบด้วย',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       4.4.1 ข้อมูลสัญญา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - เลขที่สัญญา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - หนี้คงเหลือ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       4.4.2 ข้อมูลสถานะสัญญา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - เลขที่สัญญา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - วงเงินกู้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '           - สถานะสัญญา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.5 ลงเวลาปฏิบัติงาน ประกอบด้วย ลงเวลาเข้าทำงาน ลงเวลาออกทำงาน รายงานการแสดงผลการลงเวลาปฏิบัติงาน',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.6 รายงานการลา',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.7 โครงการ Fit & Firm ประกอบด้วย บันทึกผลการออกกำลังกาย รายงานแสดงผลการออกกำลังกาย รายละเอียดภารกิจ สมัครเข้าโครงการ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.8 เส้นทางโรงพยาบาลที่ผู้จัดการกำหนด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   4.9 ข่าวสาร HR',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '5. ความรับผิดชอบของธนาคาร',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   5.1 ผู้ขอใช้บริการยอมรับว่าการให้บริการ และดำเนินการที่เกี่ยวข้อง ตลอดจนช่องทางการให้บริการต่างๆ ที่ธนาคารจัดทำขึ้นเป็นการอำนวยความสะดวกให้กับผู้ขอใช้บริการ ทั้งนี้ ธนาคารตกลงรับผิดชอบต่อผู้ขอใช้บริการในความเสียหายสืบเนื่องจากบริการนี้ในกรณีที่ธนาคารมิได้ปฏิบัติตามข้อตกลงในการให้บริการ หรือธนาคารไม่ปฏิบัติตามคำสั่งระงับการดำเนินการที่ได้รับแจ้งจากผู้ขอใช้บริการตามวิธีการและเงื่อนไขของข้อตกลง',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   5.2 เนื่องจากบริการ BAAC Astaffs  เป็นบริการที่อำนวยความสะดวกให้กับผู้ขอใช้บริการในการสอบถามข้อมูลผ่านระบบอินเตอร์เน็ต ธนาคารจึงอาจไม่สามารถให้บริการได้ชั่วคราวในกรณีที่อุปกรณ์ที่เชื่อมต่อ  ระบบสื่อสาร และ/หรือ เน็ตเวิร์คที่เกี่ยวข้องกับบริการนี้ขัดข้องเสียหาย อยู่ระหว่างการบำรุงรักษาหรือเหตุสุดวิสัยอื่นๆ  และธนาคารขอสงวนสิทธิ์ที่จะไม่ร่วมรับผิดชอบกับผู้ให้บริการเครือข่ายโทรศัพท์เคลื่อนที่ ในความผิดพลาด บกพร่อง ล่าช้า และความเสียหายใดๆ อันเกิดจากกระบวนการรับ-ส่งข้อมูลดังกล่าว ผ่านโทรศัพท์เคลื่อนที่ของผู้ให้บริการเครือข่ายโทรศัพท์เคลื่อนที่ให้แก่ผู้ขอใช้บริการหรือความเสียหายที่เกิดจากความบกพร่องของโทรศัพท์เคลื่อนที่ หรืออุปกรณ์ของผู้ขอใช้บริการ หากความเสียหายเกิดขึ้นจากเครื่องมือ หรืออุปกรณ์การใช้บริการของผู้ขอใช้บริการ หรือเกิดจากระบบเครือข่ายโทรศัพท์เคลื่อนที่ ธนาคารขอสงวนสิทธิ์ในการพิจารณาความรับผิดชอบของธนาคารต่อผู้ขอใช้บริการ ซึ่งผู้ขอใช้บริการไม่สามารถโต้แย้งใดๆได้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   5.3 ธนาคารจะไม่รับผิดชอบใดๆ ในความเสียหาย ที่เกิดขึ้นกับผู้ขอใช้บริการอันเกิดจากสาเหตุต่อไปนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       5.3.1 ผู้ขอใช้บริการมอบหรือเปิดเผยรหัสประจำตัวผู้ขอใช้บริการ และ/หรือ รหัสลับส่วนตัว (Mobile PIN/OTP) ให้ผู้อื่นทราบ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       5.3.2 ผู้ขอใช้บริการกระทำการทุจริตโดยตนเองหรือร่วมกับผู้อื่นเกี่ยวกับรหัสประจำตัวผู้ขอใช้บริการ และ/หรือ รหัสลับส่วนตัว (Mobile PIN/OTP)',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       5.3.3 ผู้ขอใช้บริการไม่รักษารหัสประจำตัวผู้ขอใช้บริการ และ/หรือ รหัสลับส่วนตัว (Mobile PIN/OTP) ไว้เป็นความลับ หรือกระทำการใดๆ ที่อาจทำให้ผู้อื่นทราบ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       5.3.4 ผู้ขอใช้บริการเปิดเผยข้อมูลด้านการเงิน การบัญชี หรือข้อมูลข่าวสารใดที่ธนาคารจัดส่งให้ผู้ขอใช้บริการ ผ่านทางโทรศัพท์เคลื่อนที่ภายใต้บริการนี้ต่อบุคคลภายนอก',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '       5.3.5 ผู้ขอใช้บริการตกลงว่า ข้อมูล รูปภาพ สัญลักษณ์ หรือเครื่องหมายใดๆ ที่เลือกเข้ามาในบริการ BAAC Astaffs  นี้ ผู้ขอใช้บริการเป็นเจ้าของข้อมูลรูปภาพ สัญลักษณ์ เครื่องหมายการค้า เครื่องหมายบริการ เจ้าของลิขสิทธิ์ และ/หรือ มีสิทธิโดยชอบในการส่งสิ่งดังกล่าวเข้าสู่บริการ BAAC Astaffs  หากผู้ขอใช้บริการนำข้อมูล รูปภาพ สัญลักษณ์ หรือเครื่องหมายใดๆ ของบุคคลอื่นมาโดยไม่ได้รับอนุญาตหรือโดยผิดกฎหมาย ผู้ขอใช้บริการตกลงรับผิดชอบในความเสียหายที่เกิดขึ้นทั้งหมด โดยธนาคารไม่มีส่วนเกี่ยวข้องใดๆ ในการกระทำผิดดังกล่าว และหากธนาคารได้รับความเสียหายใดๆ ผู้ขอใช้บริการตกลงชดใช้ค่าเสียหายที่เกิดขึ้นให้แก่ธนาคารจนครบถ้วน',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   5.4 ธนาคารมีสิทธิ์ยกเลิกการให้บริการประเภทหนึ่งประเภทใดที่ธนาคารให้บริการได้ โดยไม่ต้องแจ้งให้ผู้ขอใช้บริการทราบล่วงหน้า',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '6. การดำเนินการกรณีพบข้อผิดพลาด',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   ในกรณีที่ผู้ขอใช้บริการพบว่ามีข้อผิดพลาดหรือมีความผิดปกติใดๆ ในการใช้บริการ BAAC Astaffs  ผู้ขอใช้บริการจะต้องแจ้งเหตุที่ฝ่ายทรัพยากรมนุษย์ หรือ E-mail : pco-hris@baac.or.th ธนาคารจะดำเนินการตรวจสอบข้อเท็จจริงและค้นหาสาเหตุของข้อผิดพลาด รวมถึงแก้ไขข้อผิดพลาดดังกล่าวโดยเร็วตามมาตรฐานการให้บริการ ทั้งนี้ ธนาคารจะแจ้งผลการดำเนินการให้ผู้ขอใช้บริการทราบตามวิธีการและช่องทางต่างๆที่ธนาคารกำหนด',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '7. การระงับ และ/หรือการยกเลิกการให้บริการ',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   7.1 ในกรณีที่ผู้ขอใช้บริการ BAAC Astaffs ต้องการยกเลิกการใช้บริการ ผู้ขอใช้บริการสามารถดำเนินการได้ด้วยตนเองผ่านทางเมนู “ยกเลิกการลงทะเบียน” ผ่านทางแอปพลิเคชัน BAAC Astaffs จะถูกยกเลิกโดยอัตโนมัติ',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   7.2 เมื่อผู้ขอใช้บริการเข้าใช้บริการ BAAC Astaffs และระบบตรวจพบว่า โทรศัพท์เคลื่อนที่ของผู้ขอใช้บริการมีความเสี่ยงที่จะเกิดความเสียหายอันเนื่องมาจากการดัดแปลง แก้ไขโทรศัพท์เคลื่อนที่ของผู้ขอใช้บริการเอง หรือเกิดจากระบบเครือข่ายโทรศัพท์เคลื่อนที่ และ/หรือเหตุอื่นใด เช่น การ Jailbreak หรือ Root เป็นต้น ผู้ขอใช้บริการตกลงยินยอมให้ธนาคารระงับการให้บริการต่างๆ ภายใต้บริการ BAAC Astaffs ได้เป็นการชั่วคราวทันที โดยธนาคารไม่ต้องแจ้งให้ผู้ขอใช้บริการทราบล่วงหน้า ทั้งนี้ เพื่อป้องกันความเสียหายที่จะเกิดขึ้นกับผู้ขอใช้บริการ และผู้ขอใช้บริการยอมรับว่า การดำเนินการดังกล่าวของธนาคารเป็นการกระทำเพื่อความปลอดภัย และคุ้มครองประโยชน์ของผู้ขอใช้บริการ และธนาคารไม่ต้องรับผิดชอบในความเสียหายใดๆ ของผู้ขอใช้บริการ (ถ้ามี)',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '8. การเปิดเผยข้อมูล',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   8.1 ในกรณีที่ธนาคารมีความจำเป็นต้องเปิดเผยข้อมูลทางการเงิน หรือ เกี่ยวข้องกับการใช้บริการของผู้ใช้บริการให้แก่หน่วยงานที่มีอำนาจตามกฎหมาย ภายใต้บทบัญญัติของกฎหมาย คำสั่ง หรือกฎระเบียบของรัฐหรือหน่วยงานที่มีอำนาจตามกฎหมายนั้น ผู้ใช้บริการตกลงยินยอมให้ธนาคารเปิดเผย หรือรายงานข้อมูล และ/หรือจัดทำรายงานเกี่ยวกับข้อมูลของผู้ใช้บริการ มอบให้แก่เจ้าหน้าที่ หรือหน่วยงานรัฐที่ควบคุมกำกับดูแลธนาคารหรือหน่วยงานที่มีอำนาจตามกฎหมายนั้น ได้ทุกประการ โดยไม่ต้องแจ้งให้ผู้ใช้บริการทราบล่วงหน้า และให้ความยินยอมดังกล่าวมีผลอยู่ตลอดไป ถึงแม้ว่าจะมีการยกเลิกการใช้บริการ BAAC Astaffs แล้วก็ตาม',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   8.2 ธนาคารขอสงวนสิทธิ์ในการเปลี่ยนแปลงข้อกำหนดและเงื่อนไขการใช้บริการต่างๆ ได้ตามแต่จะเห็นสมควร นอกจากนี้ธนาคารมีสิทธิ์ ที่จะยกเลิกบริการดังกล่าวนี้ได้ ไม่ว่าทั้งหมดหรือบางส่วน โดยธนาคารจะแจ้งให้ทราบล่วงหน้าตามระยะเวลาและเงื่อนไขที่มีกฎหมายกำหนดไว้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   8.3 ผู้ขอใช้บริการยินยอมให้ธนาคารเปิดเผยข้อมูลต่างๆเพื่อประโยชน์ในการดำเนินการ และ/หรือให้บริการตามข้อตกลงและเงื่อนไขการใช้บริการนี้ อันเป็นการสนับสนุนการให้บริการของธนาคาร เช่น เพื่อทำการวิเคราะห์ป้องกันเหตุผิดปกติที่อาจเข้าข่ายการทุจริตหรือก่อให้เกิดความเสียหายต่อผู้ขอใช้บริการและ เป็นต้น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   8.4 ผู้ขอใช้บริการรับทราบและตกลงให้ธนาคารสามารถทำการบันทึก และ/หรือประมวลผลข้อมูลเกี่ยวกับผู้ขอใช้บริการและ/หรือรายการการใช้บริการและ/หรือการดำเนินการใดๆ ที่เกี่ยวข้องกับการใช้บริการของผู้ขอใช้บริการเพื่อประโยชน์ในการปรับปรุงการบริการของธนาคารและ/หรือเพื่อการใดๆ ได้ตามที่ธนาคารเห็นสมควร แต่ธนาคารไม่มีหน้าที่ต้องทำหรือเก็บรักษาบันทึก และ/หรือประมวลผลข้อมูลดังกล่าว ทั้งนี้ ผู้ขอใช้บริการตกลงให้ความยินยอมให้บันทึกและ/หรือประมวลผลข้อมูลดังกล่าวเป็นพยานหลักฐานและเป็นการยืนยันตัวตนผู้ขอใช้บริการ และธนาคารสามารถใช้บันทึกและ/หรือประมวลผลข้อมูลดังกล่าวในกระบวนการพิจารณาใดๆ หรือตามที่ธนาคารเห็นสมควร',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '9. ผู้ขอใช้บริการตกลงและยอมรับว่าการกระทำใดๆ ผ่านบริการ BAAC Astaffs ของธนาคารไม่ว่าจะเกี่ยวกับการใช้บริการประเภทใดๆ ก็ตามหากได้กระทำไปโดยการใช้รหัสประจำตัวตามข้อกำหนดและเงื่อนไขการใช้บริการนี้แล้ว ให้ถือว่าถูกต้องสมบูรณ์ผูกพันผู้ขอใช้บริการ โดยผู้ขอใช้บริการไม่ต้องลงลายมือชื่อในเอกสารใดๆ ทั้งสิ้น และผู้ขอใช้บริการตกลงรับผิดชอบการกระทำดังกล่าวเสมือนหนึ่งว่าผู้ขอใช้บริการเป็นผู้กระทำด้วยตนเอง ทั้งนี้ ไม่ว่าจะเกิดขึ้นโดยผู้ขอใช้บริการหรือบุคคลใดและไม่ว่าจะด้วยเหตุใดๆ ก็ตาม',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '10. ธนาคารได้อำนวยความสะดวกให้แก่ผู้ขอใช้บริการ BAAC Astaffs โดยการใช้ Touch ID/ Face Detection แทนการกดรหัสลับส่วนตัว (Mobile PIN) ในการเข้าู่ระบบ ซึ่งเป็นไปตามเงื่อนไขและวิธีการการใช้งาน Touch ID/ Face Detection ของ Apple Inc. ทั้งนี้ การใช้ Touch ID/ Face Detection นี้ เป็นฟังก์ชั่นเสริมของบริการ BAAC Astaffs ที่จะต้องได้รับการยินยอมจากผู้ขอใช้บริการในการเปิดใช้งานก่อน',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '11. การล่าช้า หรืองดเว้นใดๆ ในการใช้สิทธิ์ของธนาคารตามกฎหมายหรือตามเงื่อนไขต่างๆ ตลอดจนคู่มือระเบียบและบันทึกเสียงของธนาคารในระบบโทรศัพท์ ไม่ถือว่าธนาคารสละสิทธิ์ หรือให้ความยินยอมในการดำเนินการใดๆ แก่ผู้ขอใช้บริการแต่ประการใด',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '12. ธนาคารขอสงวนสิทธิ์ในการนำ BAAC Astaffs ไปใช้ในเชิงพาณิชย์',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '13. กฎหมายที่ใช้บังคับ ข้อกำหนดและเงื่อนไขการใช้บริการนี้ ให้ใช้บังคับและตีความตามกฎหมายไทย และให้ศาลที่มีเขตอำนาจในการพิจารณาข้อพิพาทที่เกิดขึ้นเกี่ยวกับการใช้บริการตามข้อกำหนด และเงื่อนไขการใช้บริการนี้',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '14. ในกรณีที่ธนาคารยินยอมให้ผู้ใช้บริการสามารถสมัครใช้บริการใดของธนาคาร หรือธุรกรรมใดผ่าน BAAC Astaffs นี้ หรือด้วยช่องทางอื่นใดตามวิธีการที่ธนาคารกำหนดแทนการลงลายมือชื่อในคำขอใช้บริการ และ/หรือ การทำธุรกรรมดังกล่าวข้างต้น หากผู้ขอใช้บริการใช้วิธีการดังกล่าวเพื่อสมัครใช้บริการหรือทำธุรกรรมที่กล่าวนั้น ผู้ขอใช้บริการตกลงผูกพันตามข้อกำหนดและเงื่อนไขเกี่ยวกับการใช้บริการดังกล่าวทุกประการ เสมือนว่าผู้ขอใช้บริการได้สมัครใช้บริการหรือทำธุรกรรมโดยการลงลายมือชื่อในคำขอใช้บริการ หรือการทำธุรกรรมดังกล่าว',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '15. ในกรณีที่ผู้ขอใช้บริการได้เคยตกลงผูกพันตามข้อกำหนดและเงื่อนไขการใช้บริการ BAAC Astaffs มาก่อนแล้ว และ/หรือด้วยวิธีการใดก็ตาม ผู้ขอใช้บริการตกลงปฏิบัติตามข้อกำหนดและเงื่อนไขการใช้บริการ BAAC Astaffs นี้แทนข้อตกลงหรือข้อกำหนดเดิมเคยผูกพันมาก่อน',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 10),
                Text(
                  '16. ความยินยอมในการเก็บรวบรวม ใช้ เปิดเผยข้อมูลส่วนบุคคล',
                  style: Theme.of(context).textTheme.smallerBoldBlack,
                ),
                SizedBox(height: 5),
                Text(
                  '   16.1 ผู้ใช้บริการตกลงยินยอมให้ธนาคารเก็บ รวบรวม ใช้ เปิดเผยข้อมูลส่วนบุคคลของผู้ขอใช้บริการที่ให้ไว้หรือมีอยู่กับธนาคาร หรือที่ธนาคารได้รับหรือเข้าถึงได้จากแหล่งอื่นตามที่หน่วยงานตามกฎหมายกำหนด โดยมีวัตถุประสงค์เพื่อการบริหารจัดการของธนาคาร การพิจารณาเสนอผลิตภัณฑ์ บริการ  การตรวจสอบธุรกรรมและข้อเสนอพิเศษต่างๆให้แก่ผู้ใช้บริการ หรือ การปฏิบัติตามกฎหมาย รวมถึงการที่ธนาคารจ้างหรือมอบหมายบุคคลอื่นดำเนินการแทน ไม่ว่าบางส่วนหรือทั้งหมดโดยผู้ใช้บริการยินยอมให้ธนาคารส่งหรือโอนข้อมูลส่วนบุคคลดังกล่าวได้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   16.2 หากธนาคารประสงค์ที่จะขอเก็บรวบรวม ใช้ และเปิดเผยข้อมูลส่วนบุคคลของผู้ใช้บริการเพิ่มเติม ผู้ใช้บริการตกลงจะให้ข้อมูลกับธนาคารตามที่ธนาคารร้องขอ และการให้ข้อมูลที่เพิ่มเติมในภายหลังนี้อยู่ภายใต้ข้อกำหนดและเงื่อนไขการใช้บริการฯ ฉบับนี้',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                Text(
                  '   16.3 ผู้ขอใช้บริการยอมรับว่าธนาคารไม่ต้องรับผิดชอบในความเสียหายใดๆ ในการเก็บ รวบรวม ใช้ เปิดเผยหรือให้ข้อมูลส่วนบุคคลที่มีอยู่กับธนาคาร จนกว่าจะมีการแจ้งเพิกถอนการใช้บริการดังกล่าวต่อธนาคาร และที่เกิดขึ้นจากความผิดพลาด ล่าช้า ชำรุดบกพร่องของระบบคอมพิวเตอร์ และ/หรือ จากการกระทำของผู้ให้บริการโทรศัพท์เคลื่อนที่ และ/หรือ บุคคลอื่นใดดังกล่าวแต่ประการใดทั้งสิ้น',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 20),
                Text(
                  '   ข้าพเจ้าได้อ่านและเข้าใจข้อกำหนดและเงื่อนไขการใช้บริการ BAAC Astaffs เรียบร้อยแล้ว และตกลงยินยอมผูกพันและรับปฏิบัติตามข้อกำหนดและเงื่อนไขดังกล่าว รวมทั้งตกลงยินยอมเสียค่าธรรมเนียมและ/หรือค่าใช้จ่ายใดๆ อันเนื่องมาจากการที่ข้าพเจ้าใช้บริการ ตามที่ธนาคารกำหนดทุกประการ แต่หากข้าพเจ้าไม่สามารถดำเนินการหรือปฏิบัติตามข้อกำหนดและเงื่อนไขดังกล่าว ไม่ว่าบางส่วนหรือทั้งหมด จนเป็นเหตุให้เกิดความเสียหายใดๆ ข้าพเจ้ายินยอมรับผิดชอบทั้งสิ้น พร้อมยกเลิกและยุติการใช้บริการ BAAC Astaffs โดยจะแจ้งให้ ธ.ก.ส. ทราบทันที',
                  style: Theme.of(context).textTheme.smallerBlack,
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _register();
                      },
                      child: Text(
                        "ยอมรับ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      onPressed: () async {
                        // Navigator.pushNamed(context, '/register');

                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.clear();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingScreen(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        "ปฎิเสธ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    // เช็คว่าเครื่องผู้ใช้ online หรือ offline
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      // ถ้า offline อยู่
      print('คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
      // แสดง alert popup
      Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต');
    } else {
      // ถ้า online แล้ว
      // เรียกต่อ API ลงทะเบียน
      DialogUtil.showLoadingDialog(context);
      var response = await CallAPI().postData(widget.registerRq, 'Register/');
      // print('########## response ===>>> $response ############');

      Navigator.pop(context);

      for (var json in response) {
        RegisterBaacModel model = RegisterBaacModel.fromJson(json);

        if (model.statusCode == '01') {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

          sharedPreferences.setString('storeDeviceIMEI', widget.registerRq['IMEI']); // เก็บ EMEI
          sharedPreferences.setString('storeEmpID', widget.registerRq['EmpID']); // รหัสพนักงาน
          sharedPreferences.setString('EmpName', model.empName); // ชื่อพนักงาน
          sharedPreferences.setInt('storeStep', 1);

          Navigator.pushReplacementNamed(context, '/pincode');
        } else {
          normalDialog(context, model.statusDesc);
        }
      }
    }
  }
}
