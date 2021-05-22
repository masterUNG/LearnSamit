class FAFRegisterRq {
  String imei;
  String pass;
  String height;
  String weight;
  String activityType;
  String telNo;
  String shirtSize;

  FAFRegisterRq({this.imei, this.pass, this.height, this.weight, this.activityType, this.telNo, this.shirtSize});

  FAFRegisterRq.fromJson(Map<String, dynamic> json) {
    imei = json['IMEI'];
    pass = json['pass'];
    height = json['Pers_high'];
    weight = json['Pers_weight'];
    activityType = json['Activity'];
    telNo = json['Tel'];
    shirtSize = json['ShirtSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IMEI'] = this.imei;
    data['pass'] = this.pass;
    data['Pers_high'] = this.height;
    data['Pers_weight'] = this.weight;
    data['Activity'] = this.activityType;
    data['Tel'] = this.telNo;
    data['ShirtSize'] = this.shirtSize;

    return data;
  }
}
