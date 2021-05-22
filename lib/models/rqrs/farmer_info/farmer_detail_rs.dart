class FarmerDetailRs {
  List<FarmerDetail> farmerList;

  FarmerDetailRs({this.farmerList});

  FarmerDetailRs.fromJson(Map<String, dynamic> json) {
    if (json['farmerList'] != null) {
      farmerList = new List<FarmerDetail>();
      json['farmerList'].forEach((v) {
        farmerList.add(new FarmerDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerList != null) {
      data['farmerList'] = this.farmerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerDetail {
  String pROFILECENTERID;
  String pROFILEAREAID;
  String aCTIVITYID;
  String pROFILEIDCARD;
  String pROFILEPREFIX;
  String pROFILENAME;
  String pROFILESURNAME;
  String hOMENO;
  String hOMEMOO;
  String hOMETAMBONCODE;
  String hOMEAMPHURCODE;
  String hOMEPROVINCECODE;
  String mOBILE;
  String dOCTYPEID;
  String dOCNO;
  String dOCRAI;
  String dOCNGAN;
  String dOCWA;
  String pLANTMOO;
  String pLANTTAMBONCODE;
  String pLANTAMPHURCODE;
  String pLANTPROVINCECODE;
  String bREEDCODE;
  String aCTRAIORI;
  String aCTNGANORI;
  String aCTWAORI;
  String pLANTDATE;
  String pRODUCEDATE;
  String sPLITGRP;
  String bREEDGROUP;
  String pRODUCEAMOUNT;
  String cONFIRMSEND;
  String eDITNAME;
  String eDITAREA;
  String eDITDATE;
  String eDITBREED;
  String sENTDATE;
  String pLANTCODE;
  String pLANTTAMBONNAME;
  String pLANTAMPHURNAME;
  String pLANTPROVINCENAME;
  String hOMECODE;
  String hOMETAMBONNAME;
  String hOMEAMPHURNAME;
  String hOMEPROVINCENAME;

  FarmerDetail({this.pROFILECENTERID, this.pROFILEAREAID, this.aCTIVITYID, this.pROFILEIDCARD, this.pROFILEPREFIX, this.pROFILENAME, this.pROFILESURNAME, this.hOMENO, this.hOMEMOO, this.hOMETAMBONCODE, this.hOMEAMPHURCODE, this.hOMEPROVINCECODE, this.mOBILE, this.dOCTYPEID, this.dOCNO, this.dOCRAI, this.dOCNGAN, this.dOCWA, this.pLANTMOO, this.pLANTTAMBONCODE, this.pLANTAMPHURCODE, this.pLANTPROVINCECODE, this.bREEDCODE, this.aCTRAIORI, this.aCTNGANORI, this.aCTWAORI, this.pLANTDATE, this.pRODUCEDATE, this.sPLITGRP, this.bREEDGROUP, this.pRODUCEAMOUNT, this.cONFIRMSEND, this.eDITNAME, this.eDITAREA, this.eDITDATE, this.eDITBREED, this.sENTDATE, this.pLANTCODE, this.pLANTTAMBONNAME, this.pLANTAMPHURNAME, this.pLANTPROVINCENAME, this.hOMECODE, this.hOMETAMBONNAME, this.hOMEAMPHURNAME, this.hOMEPROVINCENAME});

  FarmerDetail.fromJson(Map<String, dynamic> json) {
    pROFILECENTERID = json['PROFILE_CENTER_ID'];
    pROFILEAREAID = json['PROFILE_AREA_ID'];
    aCTIVITYID = json['ACTIVITY_ID'];
    pROFILEIDCARD = json['PROFILE_IDCARD'];
    pROFILEPREFIX = json['PROFILE_PREFIX'];
    pROFILENAME = json['PROFILE_NAME'];
    pROFILESURNAME = json['PROFILE_SURNAME'];
    hOMENO = json['HOME_NO'];
    hOMEMOO = json['HOME_MOO'];
    hOMETAMBONCODE = json['HOME_TAMBON_CODE'];
    hOMEAMPHURCODE = json['HOME_AMPHUR_CODE'];
    hOMEPROVINCECODE = json['HOME_PROVINCE_CODE'];
    mOBILE = json['MOBILE'];
    dOCTYPEID = json['DOC_TYPE_ID'];
    dOCNO = json['DOC_NO'];
    dOCRAI = json['DOC_RAI'];
    dOCNGAN = json['DOC_NGAN'];
    dOCWA = json['DOC_WA'];
    pLANTMOO = json['PLANT_MOO'];
    pLANTTAMBONCODE = json['PLANT_TAMBON_CODE'];
    pLANTAMPHURCODE = json['PLANT_AMPHUR_CODE'];
    pLANTPROVINCECODE = json['PLANT_PROVINCE_CODE'];
    bREEDCODE = json['BREED_CODE'];
    aCTRAIORI = json['ACT_RAI_ORI'];
    aCTNGANORI = json['ACT_NGAN_ORI'];
    aCTWAORI = json['ACT_WA_ORI'];
    pLANTDATE = json['PLANT_DATE'];
    pRODUCEDATE = json['PRODUCE_DATE'];
    sPLITGRP = json['SPLIT_GRP'];
    bREEDGROUP = json['BREED_GROUP'];
    pRODUCEAMOUNT = json['PRODUCE_AMOUNT'];
    cONFIRMSEND = json['CONFIRM_SEND'];
    eDITNAME = json['EDIT_NAME'];
    eDITAREA = json['EDIT_AREA'];
    eDITDATE = json['EDIT_DATE'];
    eDITBREED = json['EDIT_BREED'];
    sENTDATE = json['SENT_DATE'];
    pLANTCODE = json['PLANT_CODE'];
    pLANTTAMBONNAME = json['PLANT_TAMBON_NAME'];
    pLANTAMPHURNAME = json['PLANT_AMPHUR_NAME'];
    pLANTPROVINCENAME = json['PLANT_PROVINCE_NAME'];
    hOMECODE = json['HOME_CODE'];
    hOMETAMBONNAME = json['HOME_TAMBON_NAME'];
    hOMEAMPHURNAME = json['HOME_AMPHUR_NAME'];
    hOMEPROVINCENAME = json['HOME_PROVINCE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PROFILE_CENTER_ID'] = this.pROFILECENTERID;
    data['PROFILE_AREA_ID'] = this.pROFILEAREAID;
    data['ACTIVITY_ID'] = this.aCTIVITYID;
    data['PROFILE_IDCARD'] = this.pROFILEIDCARD;
    data['PROFILE_PREFIX'] = this.pROFILEPREFIX;
    data['PROFILE_NAME'] = this.pROFILENAME;
    data['PROFILE_SURNAME'] = this.pROFILESURNAME;
    data['HOME_NO'] = this.hOMENO;
    data['HOME_MOO'] = this.hOMEMOO;
    data['HOME_TAMBON_CODE'] = this.hOMETAMBONCODE;
    data['HOME_AMPHUR_CODE'] = this.hOMEAMPHURCODE;
    data['HOME_PROVINCE_CODE'] = this.hOMEPROVINCECODE;
    data['MOBILE'] = this.mOBILE;
    data['DOC_TYPE_ID'] = this.dOCTYPEID;
    data['DOC_NO'] = this.dOCNO;
    data['DOC_RAI'] = this.dOCRAI;
    data['DOC_NGAN'] = this.dOCNGAN;
    data['DOC_WA'] = this.dOCWA;
    data['PLANT_MOO'] = this.pLANTMOO;
    data['PLANT_TAMBON_CODE'] = this.pLANTTAMBONCODE;
    data['PLANT_AMPHUR_CODE'] = this.pLANTAMPHURCODE;
    data['PLANT_PROVINCE_CODE'] = this.pLANTPROVINCECODE;
    data['BREED_CODE'] = this.bREEDCODE;
    data['ACT_RAI_ORI'] = this.aCTRAIORI;
    data['ACT_NGAN_ORI'] = this.aCTNGANORI;
    data['ACT_WA_ORI'] = this.aCTWAORI;
    data['PLANT_DATE'] = this.pLANTDATE;
    data['PRODUCE_DATE'] = this.pRODUCEDATE;
    data['SPLIT_GRP'] = this.sPLITGRP;
    data['BREED_GROUP'] = this.bREEDGROUP;
    data['PRODUCE_AMOUNT'] = this.pRODUCEAMOUNT;
    data['CONFIRM_SEND'] = this.cONFIRMSEND;
    data['EDIT_NAME'] = this.eDITNAME;
    data['EDIT_AREA'] = this.eDITAREA;
    data['EDIT_DATE'] = this.eDITDATE;
    data['EDIT_BREED'] = this.eDITBREED;
    data['SENT_DATE'] = this.sENTDATE;
    data['PLANT_CODE'] = this.pLANTCODE;
    data['PLANT_TAMBON_NAME'] = this.pLANTTAMBONNAME;
    data['PLANT_AMPHUR_NAME'] = this.pLANTAMPHURNAME;
    data['PLANT_PROVINCE_NAME'] = this.pLANTPROVINCENAME;
    data['HOME_CODE'] = this.hOMECODE;
    data['HOME_TAMBON_NAME'] = this.hOMETAMBONNAME;
    data['HOME_AMPHUR_NAME'] = this.hOMEAMPHURNAME;
    data['HOME_PROVINCE_NAME'] = this.hOMEPROVINCENAME;
    return data;
  }
}
