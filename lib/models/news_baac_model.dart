class NewsBaacModel {
  String id;
  String newHead;
  String newOrg;
  String newDetail;
  String newLink;
  String newActive;
  String newDate;
  String newPic;

  NewsBaacModel(
      {this.id,
      this.newHead,
      this.newOrg,
      this.newDetail,
      this.newLink,
      this.newActive,
      this.newDate,
      this.newPic});

  NewsBaacModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newHead = json['New_Head'];
    newOrg = json['New_Org'];
    newDetail = json['New_Detail'];
    newLink = json['New_Link'];
    newActive = json['New_Active'];
    newDate = json['New_Date'];
    newPic = json['New_Pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['New_Head'] = this.newHead;
    data['New_Org'] = this.newOrg;
    data['New_Detail'] = this.newDetail;
    data['New_Link'] = this.newLink;
    data['New_Active'] = this.newActive;
    data['New_Date'] = this.newDate;
    data['New_Pic'] = this.newPic;
    return data;
  }
}

