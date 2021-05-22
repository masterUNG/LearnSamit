import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class BarcodeScanScreen extends StatefulWidget {
  BarcodeScanScreen({Key key}) : super(key: key);

  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {

  // สร้างตัวแปรไว้เก็บผลลัพธ์จาการ Scan
  ScanResult _barcode;

  // method สำหรับการสแกน
  Future scan() async {
    _barcode = await BarcodeScanner.scan();
  }

  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode and QR Code Scan'),
      ),
      body: Center(
        child: Text(
          '$_barcode', 
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}