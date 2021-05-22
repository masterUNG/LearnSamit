class FAFActivitySumDetailRs {
  String id;
  String persId;
  String activity;
  String activityDesc;
  String goal;
  String distanceSum;

  FAFActivitySumDetailRs(
      {this.id,
        this.persId,
        this.activity,
        this.activityDesc,
        this.goal,
        this.distanceSum});

  FAFActivitySumDetailRs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    persId = json['Pers_id'];
    activity = json['Activity'];
    activityDesc = json['ActivityDesc'];
    goal = json['goal'];
    distanceSum = json['Distance_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pers_id'] = this.persId;
    data['Activity'] = this.activity;
    data['ActivityDesc'] = this.activityDesc;
    data['goal'] = this.goal;
    data['Distance_sum'] = this.distanceSum;
    return data;
  }
}