class PfPolicyModel {
  String id;
  String eMPLOYEEID;
  String pOLICY;
  String iNSTRUMENTPERCENT;
  String eQUITYPERCENT;
  String eMPCONTRIBUTEPERCENT;
  String cOMPANYCONTRIBUTEPERCENT;
  String date;

  PfPolicyModel(
      {this.id,
      this.eMPLOYEEID,
      this.pOLICY,
      this.iNSTRUMENTPERCENT,
      this.eQUITYPERCENT,
      this.eMPCONTRIBUTEPERCENT,
      this.cOMPANYCONTRIBUTEPERCENT,
      this.date});

  PfPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    pOLICY = json['POLICY'];
    iNSTRUMENTPERCENT = json['INSTRUMENT_PERCENT'];
    eQUITYPERCENT = json['EQUITY_PERCENT'];
    eMPCONTRIBUTEPERCENT = json['EMP_CONTRIBUTE_PERCENT'];
    cOMPANYCONTRIBUTEPERCENT = json['COMPANY_CONTRIBUTE_PERCENT'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['POLICY'] = this.pOLICY;
    data['INSTRUMENT_PERCENT'] = this.iNSTRUMENTPERCENT;
    data['EQUITY_PERCENT'] = this.eQUITYPERCENT;
    data['EMP_CONTRIBUTE_PERCENT'] = this.eMPCONTRIBUTEPERCENT;
    data['COMPANY_CONTRIBUTE_PERCENT'] = this.cOMPANYCONTRIBUTEPERCENT;
    data['Date'] = this.date;
    return data;
  }
}

