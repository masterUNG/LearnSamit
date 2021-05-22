class FundDetailModel {
  String id;
  String objectiveName;
  String groupId;
  String rowNumber;
  String businessArea;
  String employeeNo;
  String memberName;
  String positionName;
  String divisionName;
  String contractNo;
  String receiveMaxtime;
  String payPerPeriod;
  String loanAmount;
  String firstPaymentDate;
  String sumPaymentAmountReal;
  String debtBalance;
  String received;

  FundDetailModel(
      {this.id,
      this.objectiveName,
      this.groupId,
      this.rowNumber,
      this.businessArea,
      this.employeeNo,
      this.memberName,
      this.positionName,
      this.divisionName,
      this.contractNo,
      this.receiveMaxtime,
      this.payPerPeriod,
      this.loanAmount,
      this.firstPaymentDate,
      this.sumPaymentAmountReal,
      this.debtBalance,
      this.received});

  FundDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectiveName = json['ObjectiveName'];
    groupId = json['GroupId'];
    rowNumber = json['RowNumber'];
    businessArea = json['BusinessArea'];
    employeeNo = json['EmployeeNo'];
    memberName = json['MemberName'];
    positionName = json['PositionName'];
    divisionName = json['DivisionName'];
    contractNo = json['ContractNo'];
    receiveMaxtime = json['ReceiveMaxtime'];
    payPerPeriod = json['PayPerPeriod'];
    loanAmount = json['LoanAmount'];
    firstPaymentDate = json['FirstPaymentDate'];
    sumPaymentAmountReal = json['SumPaymentAmountReal'];
    debtBalance = json['DebtBalance'];
    received = json['received'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ObjectiveName'] = this.objectiveName;
    data['GroupId'] = this.groupId;
    data['RowNumber'] = this.rowNumber;
    data['BusinessArea'] = this.businessArea;
    data['EmployeeNo'] = this.employeeNo;
    data['MemberName'] = this.memberName;
    data['PositionName'] = this.positionName;
    data['DivisionName'] = this.divisionName;
    data['ContractNo'] = this.contractNo;
    data['ReceiveMaxtime'] = this.receiveMaxtime;
    data['PayPerPeriod'] = this.payPerPeriod;
    data['LoanAmount'] = this.loanAmount;
    data['FirstPaymentDate'] = this.firstPaymentDate;
    data['SumPaymentAmountReal'] = this.sumPaymentAmountReal;
    data['DebtBalance'] = this.debtBalance;
    data['received'] = this.received;
    return data;
  }
}

