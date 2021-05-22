class FundLoanModel {
  String id;
  String employeeNo;
  String contractNo;
  String loanAmount;
  String stateName;

  FundLoanModel(
      {this.id,
      this.employeeNo,
      this.contractNo,
      this.loanAmount,
      this.stateName});

  FundLoanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeNo = json['EmployeeNo'];
    contractNo = json['ContractNo'];
    loanAmount = json['LoanAmount'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['EmployeeNo'] = this.employeeNo;
    data['ContractNo'] = this.contractNo;
    data['LoanAmount'] = this.loanAmount;
    data['StateName'] = this.stateName;
    return data;
  }
}

