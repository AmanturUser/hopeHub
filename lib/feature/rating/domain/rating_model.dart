class RatingModel {
  String? name;
  String? surname;
  int? rating;
  String? photo;
  List<Users>? users;
  int? currentPage;
  int? totalPages;

  RatingModel(
      {this.name,
        this.surname,
        this.rating,
        this.photo,
        this.users,
        this.currentPage,
        this.totalPages});

  RatingModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    rating = json['rating'];
    photo = json['photo'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['rating'] = this.rating;
    data['photo'] = this.photo;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Users {
  String? sId;
  int? rating;
  String? name;
  String? className;
  String? schoolName;

  Users({this.sId, this.rating, this.name, this.className, this.schoolName});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    name = json['name'];
    className = json['className'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['name'] = this.name;
    data['className'] = this.className;
    data['schoolName'] = this.schoolName;
    return data;
  }
}
