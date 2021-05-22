class FarmerDetailRq {
  String imei;
  String pass;
  String firstName;
  String lastName;
  String citizenId;

  FarmerDetailRq({
    this.imei,
    this.pass,
    this.firstName,
    this.lastName,
    this.citizenId,
  });

  FarmerDetailRq.fromJson(Map<String, dynamic> json) {
    imei = json['IMEI'];
    pass = json['pass'];
    firstName = json['FName_search'];
    lastName = json['LName_search'];
    citizenId = json['Ciz_search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IMEI'] = this.imei;
    data['pass'] = this.pass;
    data['FName_search'] = this.firstName;
    data['LName_search'] = this.lastName;
    data['Ciz_search'] = this.citizenId;

    return data;
  }
}
