class FAFAddActivityRs {
  String statusCode;
  String statusDesc;

  FAFAddActivityRs({this.statusCode, this.statusDesc});

  FAFAddActivityRs.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusDesc = json['statusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusDesc'] = this.statusDesc;
    return data;
  }
}
