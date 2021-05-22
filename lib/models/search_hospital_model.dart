class SearchHospitalModel {
  String id;
  String name;
  String latitude;
  String longitude;
  String description;

  SearchHospitalModel(
      {this.id, this.name, this.latitude, this.longitude, this.description});

  SearchHospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Description'] = this.description;
    return data;
  }
}

