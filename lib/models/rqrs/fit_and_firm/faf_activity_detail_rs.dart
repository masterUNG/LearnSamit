import 'package:ASmartApp/utils/date_time_util.dart';

class FAFActivityDetailRs {
  List<FAFActivityDetail> fafActivityDetails;

  FAFActivityDetailRs({this.fafActivityDetails});

  FAFActivityDetailRs.fromJson(Map<String, dynamic> json) {
    if (json['fafActivityDetails'] != null) {
      fafActivityDetails = new List<FAFActivityDetail>();
      json['fafActivityDetails'].forEach((v) {
        fafActivityDetails.add(new FAFActivityDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fafActivityDetails != null) {
      data['fafActivityDetails'] = this.fafActivityDetails.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FAFActivityDetail {
  String id;
  String persId;
  DateTime activityDate;
  String distance;
  String base64;
  DateTime createDate;

  FAFActivityDetail({this.id, this.persId, this.activityDate, this.distance, this.base64, this.createDate});

  FAFActivityDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    persId = json['Pers_id'];
    activityDate = DateTimeUtil.toDateTime(json['Activity_date'], format: APP_DATE_TIME_FORMAT);
    distance = json['Distance'];
    base64 = json['Base64'];
    createDate = DateTimeUtil.toDateTime(json['Create_date'], format: APP_DATE_TIME_FORMAT);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pers_id'] = this.persId;
    data['Activity_date'] = DateTimeUtil.toDateTimeString(this.activityDate, APP_DATE_TIME_FORMAT);
    data['Distance'] = this.distance;
    data['Base64'] = this.base64;
    data['Create_date'] = DateTimeUtil.toDateTimeString(this.createDate, APP_DATE_TIME_FORMAT);
    return data;
  }
}
