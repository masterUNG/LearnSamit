class FAFCheckRegisterRs {
  List<FAFCheckRegister> fafCheckRegisters;

  FAFCheckRegisterRs({this.fafCheckRegisters});

  FAFCheckRegisterRs.fromJson(Map<String, dynamic> json) {
    if (json['fafCheckRegisters'] != null) {
      fafCheckRegisters = new List<FAFCheckRegister>();
      json['fafCheckRegisters'].forEach((v) {
        fafCheckRegisters.add(new FAFCheckRegister.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fafCheckRegisters != null) {
      data['fafCheckRegisters'] = this.fafCheckRegisters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAFCheckRegister {
  String persId;
  String activity;
  String activityDesc;
  String tel;
  String shirtSize;
  String registerDate;
  String statusCode;
  String statusDesc;

  FAFCheckRegister({this.persId, this.activity, this.activityDesc, this.tel, this.shirtSize, this.registerDate, this.statusCode, this.statusDesc});

  FAFCheckRegister.fromJson(Map<String, dynamic> json) {
    persId = json['Pers_id'];
    activity = json['Activity'];
    activityDesc = json['ActivityDesc'];
    tel = json['Tel'];
    shirtSize = json['ShirtSize'];
    registerDate = json['Register_date'];
    statusCode = json['statusCode'];
    statusDesc = json['statusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pers_id'] = this.persId;
    data['Activity'] = this.activity;
    data['ActivityDesc'] = this.activityDesc;
    data['Tel'] = this.tel;
    data['ShirtSize'] = this.shirtSize;
    data['Register_date'] = this.registerDate;
    data['statusCode'] = this.statusCode;
    data['statusDesc'] = this.statusDesc;
    return data;
  }
}
