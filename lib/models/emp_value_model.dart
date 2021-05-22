class EmpPFValueModel {
  String id;
  String nAVDATE;
  String eMPLOYEEID;
  String pLANCODE;
  String cOMPANYFUND1;
  String nUNITFUND1;
  String cONTEFUND1;
  String eARNEFUND1;
  String cONTCFUND1;
  String eARNCFUND1;
  String tOTALFUND1;
  String cOMPANYFUND2;
  String nUNITFUND2;
  String cONTEFUND2;
  String eARNEFUND2;
  String cONTCFUND2;
  String eARNCFUND2;
  String tOTALFUND2;
  String tOTALFUND1FUND2;
  String date;

  EmpPFValueModel(
      {this.id,
      this.nAVDATE,
      this.eMPLOYEEID,
      this.pLANCODE,
      this.cOMPANYFUND1,
      this.nUNITFUND1,
      this.cONTEFUND1,
      this.eARNEFUND1,
      this.cONTCFUND1,
      this.eARNCFUND1,
      this.tOTALFUND1,
      this.cOMPANYFUND2,
      this.nUNITFUND2,
      this.cONTEFUND2,
      this.eARNEFUND2,
      this.cONTCFUND2,
      this.eARNCFUND2,
      this.tOTALFUND2,
      this.tOTALFUND1FUND2,
      this.date});

  EmpPFValueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAVDATE = json['NAVDATE'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    pLANCODE = json['PLANCODE'];
    cOMPANYFUND1 = json['COMPANY_FUND1'];
    nUNITFUND1 = json['NUNIT_FUND1'];
    cONTEFUND1 = json['CONTE_FUND1'];
    eARNEFUND1 = json['EARNE_FUND1'];
    cONTCFUND1 = json['CONTC_FUND1'];
    eARNCFUND1 = json['EARNC_FUND1'];
    tOTALFUND1 = json['TOTAL_FUND1'];
    cOMPANYFUND2 = json['COMPANY_FUND2'];
    nUNITFUND2 = json['NUNIT_FUND2'];
    cONTEFUND2 = json['CONTE_FUND2'];
    eARNEFUND2 = json['EARNE_FUND2'];
    cONTCFUND2 = json['CONTC_FUND2'];
    eARNCFUND2 = json['EARNC_FUND2'];
    tOTALFUND2 = json['TOTAL_FUND2'];
    tOTALFUND1FUND2 = json['TOTAL_FUND1_FUND2'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAVDATE'] = this.nAVDATE;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['PLANCODE'] = this.pLANCODE;
    data['COMPANY_FUND1'] = this.cOMPANYFUND1;
    data['NUNIT_FUND1'] = this.nUNITFUND1;
    data['CONTE_FUND1'] = this.cONTEFUND1;
    data['EARNE_FUND1'] = this.eARNEFUND1;
    data['CONTC_FUND1'] = this.cONTCFUND1;
    data['EARNC_FUND1'] = this.eARNCFUND1;
    data['TOTAL_FUND1'] = this.tOTALFUND1;
    data['COMPANY_FUND2'] = this.cOMPANYFUND2;
    data['NUNIT_FUND2'] = this.nUNITFUND2;
    data['CONTE_FUND2'] = this.cONTEFUND2;
    data['EARNE_FUND2'] = this.eARNEFUND2;
    data['CONTC_FUND2'] = this.cONTCFUND2;
    data['EARNC_FUND2'] = this.eARNCFUND2;
    data['TOTAL_FUND2'] = this.tOTALFUND2;
    data['TOTAL_FUND1_FUND2'] = this.tOTALFUND1FUND2;
    data['Date'] = this.date;
    return data;
  }
}

