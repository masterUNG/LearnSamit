import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rs.dart';
import 'package:flutter/material.dart';
import 'package:ASmartApp/themes/theme.dart';

class FarmerResult extends StatelessWidget {
  final FarmerDetailRs _farmerDetailRs;

  FarmerResult(this._farmerDetailRs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลเกษตรกร'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ผลการค้นหา ${_farmerDetailRs?.farmerList?.length} รายการ',
                      style: Theme.of(context).textTheme.largeBoldBlack,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        buildCardResult(context),
                      ],
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

  Widget buildCardResult(BuildContext context) {
    if (_farmerDetailRs == null || _farmerDetailRs.farmerList == null || _farmerDetailRs.farmerList.isEmpty) {
      return Text(
        'ไม่พบข้อมูล',
        style: Theme.of(context).textTheme.boldRed,
      );
    }

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _farmerDetailRs.farmerList.length,
      itemBuilder: (context, index) {
        FarmerDetail farmerDetail = _farmerDetailRs.farmerList[index];

        Widget buildRow(String text) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.smallBlack,
                ),
              ),
            ],
          );
        }

        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${index + 1}.',
                      style: Theme.of(context).textTheme.largeBoldRed,
                    ),
                  ],
                ),
                buildRow('${farmerDetail.pROFILEPREFIX}${farmerDetail.pROFILENAME}  ${farmerDetail.pROFILESURNAME}'),
                buildRow('เบอร์โทรศัพท์ ${farmerDetail.mOBILE}'),
                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
                buildRow('ที่อยู่'),
                buildRow('บ้านเลขที่ ${farmerDetail.hOMENO}   ตำบล ${farmerDetail.hOMETAMBONNAME}'),
                buildRow('อำเภอ ${farmerDetail.hOMEAMPHURNAME}   จังหวัด ${farmerDetail.hOMEPROVINCENAME}'),
                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
                buildRow('พื้นที่ปลูก'),
                buildRow('${farmerDetail.aCTRAIORI} ไร่   ${farmerDetail.aCTNGANORI} งาน   ${farmerDetail.aCTWAORI} วา'),
                buildRow('วันที่ปลูก ${farmerDetail.pLANTDATE}   ตำบล ${farmerDetail.hOMETAMBONNAME}'),
                buildRow('อำเภอ ${farmerDetail.hOMEAMPHURNAME}   จังหวัด ${farmerDetail.hOMEPROVINCENAME}'),
                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
                buildRow('พันธ์พืช'),
                buildRow('รหัสพันธ์พืช ${farmerDetail.bREEDCODE}   กลุ่มพันธ์พืช ${farmerDetail.bREEDGROUP}'),
                buildRow('วันที่ออกผล ${farmerDetail.pRODUCEDATE}   จำนวนผล ${farmerDetail.pRODUCEAMOUNT}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
