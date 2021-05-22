class FAFAddActivityRq {
  String imei;
  String pass;
  String activityDate;
  String activityDistance;
  String activityImage;

  FAFAddActivityRq({
    this.imei,
    this.pass,
    this.activityDate,
    this.activityDistance,
    this.activityImage,
  });

  FAFAddActivityRq.fromJson(Map<String, dynamic> json) {
    imei = json['IMEI'];
    pass = json['pass'];
    activityDate = json['Activity_date'];
    activityDistance = json['Distance'];
    activityImage = json['Base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IMEI'] = this.imei;
    data['pass'] = this.pass;
    data['Activity_date'] = this.activityDate;
    data['Distance'] = this.activityDistance;
    data['Base64'] = this.activityImage;

    return data;
  }
}
