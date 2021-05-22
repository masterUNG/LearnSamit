class FAFRegisterRs {
  String statusCode;
  String statusDesc;

  FAFRegisterRs({this.statusCode, this.statusDesc});

  FAFRegisterRs.fromJson(Map<String, dynamic> json) {
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
