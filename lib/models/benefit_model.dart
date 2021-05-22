class BenefitModel {
  String depNo;
  String dataDate;
  String listName;
  String amount;
  String postDate;

  BenefitModel(
      {this.depNo, this.dataDate, this.listName, this.amount, this.postDate});

  BenefitModel.fromJson(Map<String, dynamic> json) {
    depNo = json['DepNo'];
    dataDate = json['DataDate'];
    listName = json['ListName'];
    amount = json['Amount'];
    postDate = json['postDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepNo'] = this.depNo;
    data['DataDate'] = this.dataDate;
    data['ListName'] = this.listName;
    data['Amount'] = this.amount;
    data['postDate'] = this.postDate;
    return data;
  }
}

