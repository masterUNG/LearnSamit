import 'dart:convert';

List<BaacTimeDetailModel> baacTimeDetailModelFromJson(String str) => List<BaacTimeDetailModel>.from(json.decode(str).map((x) => BaacTimeDetailModel.fromJson(x)));

String baacTimeDetailModelToJson(List<BaacTimeDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaacTimeDetailModel {
    BaacTimeDetailModel({
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

    factory BaacTimeDetailModel.fromJson(Map<String, dynamic> json) => BaacTimeDetailModel(
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