class ProfileModel {
  String? id;
  String? name;
  String? surname;
  int? rating;
  String? photo;
  int? projects;
  int? ideas;
  int? surveys;
  String? school;
  ClassUser? classUser;
  List<ClassUser>? classes;

  ProfileModel(
      {this.id,
        this.name,
        this.surname,
        this.rating,
        this.photo,
        this.projects,
        this.ideas,
        this.surveys,
        this.school,
        this.classUser,
        this.classes});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    rating = json['rating'];
    photo = json['photo'];
    projects = json['projects'];
    ideas = json['ideas'];
    surveys = json['surveys'];
    school = json['school'];
    classUser = json['classUser'] != null
        ? new ClassUser.fromJson(json['classUser'])
        : null;
    if (json['classes'] != null) {
      classes = <ClassUser>[];
      json['classes'].forEach((v) {
        classes!.add(new ClassUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['rating'] = this.rating;
    data['photo'] = this.photo;
    data['projects'] = this.projects;
    data['ideas'] = this.ideas;
    data['surveys'] = this.surveys;
    data['school'] = this.school;
    if (this.classUser != null) {
      data['classUser'] = this.classUser!.toJson();
    }
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassUser {
  String? id;
  String? name;

  ClassUser({this.id, this.name});

  ClassUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
