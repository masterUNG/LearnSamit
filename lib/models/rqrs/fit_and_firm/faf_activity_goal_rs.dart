class FAFActivityGoalRs {
  List<FAFActivityGoal> fafActivityGoals;

  FAFActivityGoalRs({this.fafActivityGoals});

  FAFActivityGoalRs.fromJson(Map<String, dynamic> json) {
    if (json['fafActivityGoals'] != null) {
      fafActivityGoals = new List<FAFActivityGoal>();
      json['fafActivityGoals'].forEach((v) {
        fafActivityGoals.add(new FAFActivityGoal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fafActivityGoals != null) {
      data['fafActivityGoals'] = this.fafActivityGoals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAFActivityGoal {
  String id;
  String type;
  String activityDesc;
  String unit;
  String goal;
  String goal30;
  String goal10;
  String goalTeam;
  String goal30Team;

  FAFActivityGoal({this.id, this.type, this.activityDesc, this.unit, this.goal, this.goal30, this.goal10, this.goalTeam, this.goal30Team});

  FAFActivityGoal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    activityDesc = json['ActivityDesc'];
    unit = json['unit'];
    goal = json['goal'];
    goal30 = json['goal30'];
    goal10 = json['goal10'];
    goalTeam = json['goal_team'];
    goal30Team = json['goal30_team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['ActivityDesc'] = this.activityDesc;
    data['unit'] = this.unit;
    data['goal'] = this.goal;
    data['goal30'] = this.goal30;
    data['goal10'] = this.goal10;
    data['goal_team'] = this.goalTeam;
    data['goal30_team'] = this.goal30Team;
    return data;
  }
}
