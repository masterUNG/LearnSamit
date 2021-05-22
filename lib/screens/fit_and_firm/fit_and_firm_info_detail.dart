import 'dart:typed_data';
import 'dart:convert';

import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_detail_rs.dart';
import 'package:ASmartApp/utils/string_util.dart';
import 'package:flutter/material.dart';

class FitAndFirmInfoDetail extends StatelessWidget {
  final FAFActivityDetail activity;

  FitAndFirmInfoDetail(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการออกกำลังกายของฉัน'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            buildImage(context),
            buildInfo(context),
          ],
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    if (activity == null || StringUtil.isNullOrEmpty(activity.base64)) {
      return SizedBox.shrink();
    }
    try {
      Uint8List bytes = Base64Decoder().convert(activity.base64);
      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Image.memory(
          bytes,
          width: 420,
          height: 420,
        ),
      );
    } catch (error, stackTrace) {
      return SizedBox.shrink();
    }
  }

  Widget buildInfo(BuildContext context) {
    if (activity == null) {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextRow('รายการ', activity.id),
          buildTextRow('วันที่ออกกำลังกาย', StringUtil.toTruncDateFormat(activity.activityDate, format: 'dd/MM/yyyy')),
          buildTextRow('ผลการออกกำลังกาย', activity.distance),
          buildTextRow('วันที่บันทึก', StringUtil.toTruncDateFormat(activity.createDate, format: 'dd/MM/yyyy')),
        ],
      ),
    );
  }

  Widget buildTextRow(String label, String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Text(
              label ?? '',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              data ?? '',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
