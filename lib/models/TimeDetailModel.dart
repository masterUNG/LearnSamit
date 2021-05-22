import 'dart:convert';

List<TimeDetailModel> timeDetailModelFromJson(String str) => List<TimeDetailModel>.from(json.decode(str).map((x) => TimeDetailModel.fromJson(x)));

String timeDetailModelToJson(List<TimeDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeDetailModel {
    TimeDetailModel({
        this.no,
        this.empId,
        this.type,
        this.date,
        this.time,
    });

    String no;
    String empId;
    String type;
    String date;
    String time;

    factory TimeDetailModel.fromJson(Map<String, dynamic> json) => TimeDetailModel(
        no: json["No"] == null ? null : json["No"],
        empId: json["EmpID"] == null ? null : json["EmpID"],
        type: json["type"] == null ? null : json["type"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
    );

    Map<String, dynamic> toJson() => {
        "No": no == null ? null : no,
        "EmpID": empId == null ? null : empId,
        "type": type == null ? null : type,
        "date": date == null ? null : date,
        "time": time == null ? null : time,
    };
}