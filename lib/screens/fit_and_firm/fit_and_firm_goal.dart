import 'dart:typed_data';

import 'package:ASmartApp/utils/string_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:photo_view/photo_view.dart';

class FitAndFirmGoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดรายการออกกำลังกาย'),
      ),
      body: SafeArea(
        child: buildImage(context),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    // String testBase64Image = '';
    //
    // if (StringUtil.isNullOrEmpty(testBase64Image)) {
    //   return SizedBox.shrink();
    // }
    // try {
    //   Uint8List bytes = Base64Decoder().convert(testBase64Image);
    //   return Card(
    //     elevation: 8,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //     child: PhotoView(
    //       imageProvider: ,
    //     ),
    //   );
    // } catch (error, stackTrace) {
    //   return SizedBox.shrink();
    // }

    return Container(
      child: PhotoView(
        imageProvider: AssetImage('assets/images/fit_and_firm_goal.png'),
      ),
    );

  }
}
