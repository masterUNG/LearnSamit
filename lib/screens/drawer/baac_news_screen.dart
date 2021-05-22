import 'package:flutter/material.dart';

class BaacNews extends StatefulWidget {
  BaacNews({Key key}) : super(key: key);

  @override
  _BaacNewsState createState() => _BaacNewsState();
}

class _BaacNewsState extends State<BaacNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าวสาร'),
      ),
       body: Center(
         child: Text('เนื้อหาหน้าข่าวสาร'),
       ),
    );
  }
}