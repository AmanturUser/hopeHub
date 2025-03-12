class DashboardModel {
  String? userName;
  List<Ideas>? ideas;
  List<Projects>? projects;
  List<UserSurveys>? userSurveys;

  DashboardModel({this.userName, this.ideas, this.projects, this.userSurveys});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    if (json['ideas'] != null) {
      ideas = <Ideas>[];
      json['ideas'].forEach((v) {
        ideas!.add(new Ideas.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    if (json['userSurveys'] != null) {
      userSurveys = <UserSurveys>[];
      json['userSurveys'].forEach((v) {
        userSurveys!.add(new UserSurveys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.userSurveys != null) {
      data['userSurveys'] = this.userSurveys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ideas {
  String? sId;
  String? name;
  String? description;

  Ideas({this.sId, this.name, this.description});

  Ideas.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
  }
}

class Projects {
  String? sId;
  String? name;
  String? description;

  Projects({this.sId, this.name, this.description});

  Projects.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class UserSurveys {
  String? id;
  String? name;
  String? description;
  List<Options>? options;
  int? selectedOption;

  UserSurveys(
      {this.id,
        this.name,
        this.description,
        this.options,
        this.selectedOption});

  UserSurveys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    selectedOption = json['selectedOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['selectedOption'] = this.selectedOption;
    return data;
  }
}

class Options {
  int? optionId;
  String? optionName;

  Options({this.optionId, this.optionName});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    data['optionName'] = this.optionName;
    return data;
  }
}
