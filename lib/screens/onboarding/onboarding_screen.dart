import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/welcome');
  }

  Widget _buildImage(String assetName) {
    return Align(
      child:
          Image.asset('assets/images/onboarding/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "จัดสรรเงินออมของคุณ",
          body: "เริ่มต้นจัดการเงินออมกับเราได้ง่ายๆ",
          image: _buildImage('onboard1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "แบ่งปันการใช้งานร่วมกัน",
          body: "ระบบช่วยแบ่งปันแนวคิดและการทำงานร่วมกัน",
          image: _buildImage('onboard2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "ลดเวลา เพิ่มมูลค่าเงินในอนาคต",
          body:
              "ประหยัดเวลาการทำงานของคุณ ช่วยเพิ่มมูลค่าให้เงินในอนาคตของคุณงอกเงยมากกว่า",
          image: _buildImage('onboard3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "ธนาคารเพื่ออนาคตที่ดี",
          body: "เริ่มต้นกับเราตั้งแต่วันนี้ เพื่อนาคตที่ดี",
          image: _buildImage('onboard5'),
          footer: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/welcome');
            },
            child: const Text(
              'เริ่มต้นใช้งานกันเลย',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            color: Colors.green,
          ),
          decoration: pageDecoration,
        ),
      ],

      
      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('ข้าม'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('เข้าใช้งาน',
          style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
