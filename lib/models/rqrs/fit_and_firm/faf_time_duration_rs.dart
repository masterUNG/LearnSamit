import 'package:ASmartApp/utils/date_time_util.dart';

class FAFActivityTimeDurationRs {
  List<FAFActivityTimeDuration> fafActivityTimeDurations;

  FAFActivityTimeDurationRs({this.fafActivityTimeDurations});

  FAFActivityTimeDurationRs.fromJson(Map<String, dynamic> json) {
    if (json['fafActivityTimeDurations'] != null) {
      fafActivityTimeDurations = new List<FAFActivityTimeDuration>();
      json['fafActivityTimeDurations'].forEach((v) {
        fafActivityTimeDurations.add(new FAFActivityTimeDuration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fafActivityTimeDurations != null) {
      data['fafActivityTimeDurations'] = this.fafActivityTimeDurations.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FAFActivityTimeDuration {
  String id;
  String activity;
  DateTime startDate;
  DateTime endDate;
  String status;

  FAFActivityTimeDuration({this.id, this.activity, this.startDate, this.endDate, this.status});

  FAFActivityTimeDuration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activity = json['activity'];
    startDate = DateTimeUtil.toDateTime(json['start_date'], format: APP_DATE_TIME_FORMAT);
    endDate = DateTimeUtil.toDateTime(json['end_date'], format: APP_DATE_TIME_FORMAT);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity'] = this.activity;
    data['start_date'] = DateTimeUtil.toDateTimeString(this.startDate, APP_DATE_TIME_FORMAT);
    data['end_date'] = DateTimeUtil.toDateTimeString(this.endDate, APP_DATE_TIME_FORMAT);
    data['status'] = this.status;
    return data;
  }
}
