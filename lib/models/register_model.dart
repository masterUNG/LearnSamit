class RegisterBaacModel {
  String statusCode;
  String statusDesc;
  String empName;

  RegisterBaacModel({this.statusCode, this.statusDesc, this.empName});

  RegisterBaacModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusDesc = json['statusDesc'];
    empName = json['EmpName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusDesc'] = this.statusDesc;
    data['EmpName'] = this.empName;
    return data;
  }
}

