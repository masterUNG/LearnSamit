class UserProfileRs {
  List<UserProfile> userProfiles;

  UserProfileRs({this.userProfiles});

  UserProfileRs.fromJson(Map<String, dynamic> json) {
    if (json['userProfiles'] != null) {
      userProfiles = new List<UserProfile>();
      json['userProfiles'].forEach((v) {
        userProfiles.add(new UserProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfiles != null) {
      data['userProfiles'] = this.userProfiles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProfile {
  String eMPLOYEEID;
  String pNAMETH;
  String rANK;
  String fNAMETH;
  String lNAMETH;
  String cITIZENID;
  String pOSITIONNAME;
  String oRGANISATIONID;
  String oRGANISATIONNAME;
  String cOSTCENTERID;
  String cOSTCENTERNAME;
  String eMPLOYMENTDATE;
  String sALARY;
  String bIRTHDATE;
  String mARRIAGESTATUS;
  Null aDDRESS;
  String sALARYACCNO;
  String cREMATIONWELFAREID;
  String lABORUNIONID;
  String date;

  UserProfile({this.eMPLOYEEID, this.pNAMETH, this.rANK, this.fNAMETH, this.lNAMETH, this.cITIZENID, this.pOSITIONNAME, this.oRGANISATIONID, this.oRGANISATIONNAME, this.cOSTCENTERID, this.cOSTCENTERNAME, this.eMPLOYMENTDATE, this.sALARY, this.bIRTHDATE, this.mARRIAGESTATUS, this.aDDRESS, this.sALARYACCNO, this.cREMATIONWELFAREID, this.lABORUNIONID, this.date});

  UserProfile.fromJson(Map<String, dynamic> json) {
    eMPLOYEEID = json['EMPLOYEE_ID'];
    pNAMETH = json['PNAME_TH'];
    rANK = json['RANK'];
    fNAMETH = json['FNAME_TH'];
    lNAMETH = json['LNAME_TH'];
    cITIZENID = json['CITIZEN_ID'];
    pOSITIONNAME = json['POSITION_NAME'];
    oRGANISATIONID = json['ORGANISATION_ID'];
    oRGANISATIONNAME = json['ORGANISATION_NAME'];
    cOSTCENTERID = json['COST_CENTER_ID'];
    cOSTCENTERNAME = json['COST_CENTER_NAME'];
    eMPLOYMENTDATE = json['EMPLOYMENT_DATE'];
    sALARY = json['SALARY'];
    bIRTHDATE = json['BIRTH_DATE'];
    mARRIAGESTATUS = json['MARRIAGE_STATUS'];
    aDDRESS = json['ADDRESS'];
    sALARYACCNO = json['SALARY_ACC_NO'];
    cREMATIONWELFAREID = json['CREMATION_WELFARE_ID'];
    lABORUNIONID = json['LABOR_UNION_ID'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['PNAME_TH'] = this.pNAMETH;
    data['RANK'] = this.rANK;
    data['FNAME_TH'] = this.fNAMETH;
    data['LNAME_TH'] = this.lNAMETH;
    data['CITIZEN_ID'] = this.cITIZENID;
    data['POSITION_NAME'] = this.pOSITIONNAME;
    data['ORGANISATION_ID'] = this.oRGANISATIONID;
    data['ORGANISATION_NAME'] = this.oRGANISATIONNAME;
    data['COST_CENTER_ID'] = this.cOSTCENTERID;
    data['COST_CENTER_NAME'] = this.cOSTCENTERNAME;
    data['EMPLOYMENT_DATE'] = this.eMPLOYMENTDATE;
    data['SALARY'] = this.sALARY;
    data['BIRTH_DATE'] = this.bIRTHDATE;
    data['MARRIAGE_STATUS'] = this.mARRIAGESTATUS;
    data['ADDRESS'] = this.aDDRESS;
    data['SALARY_ACC_NO'] = this.sALARYACCNO;
    data['CREMATION_WELFARE_ID'] = this.cREMATIONWELFAREID;
    data['LABOR_UNION_ID'] = this.lABORUNIONID;
    data['Date'] = this.date;
    return data;
  }
}
