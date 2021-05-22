class EmpleaveModel {
  String id;
  String eMPLOYEEID;
  String aCCOUNTYEAR;
  String aBSENCETYPE;
  String aBSENCENAME;
  String qUOTADAY;
  String dAYUSED;
  String hOURUSED;
  String date;

  EmpleaveModel(
      {this.id,
      this.eMPLOYEEID,
      this.aCCOUNTYEAR,
      this.aBSENCETYPE,
      this.aBSENCENAME,
      this.qUOTADAY,
      this.dAYUSED,
      this.hOURUSED,
      this.date});

  EmpleaveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    aCCOUNTYEAR = json['ACCOUNT_YEAR'];
    aBSENCETYPE = json['ABSENCE_TYPE'];
    aBSENCENAME = json['ABSENCE_NAME'];
    qUOTADAY = json['QUOTA_DAY'];
    dAYUSED = json['DAY_USED'];
    hOURUSED = json['HOUR_USED'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['ACCOUNT_YEAR'] = this.aCCOUNTYEAR;
    data['ABSENCE_TYPE'] = this.aBSENCETYPE;
    data['ABSENCE_NAME'] = this.aBSENCENAME;
    data['QUOTA_DAY'] = this.qUOTADAY;
    data['DAY_USED'] = this.dAYUSED;
    data['HOUR_USED'] = this.hOURUSED;
    data['Date'] = this.date;
    return data;
  }
}

