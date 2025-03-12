class RatingSchoolsModel {
  String? sId;
  String? userSchoolName;
  int? userSchoolRating;
  List<Schools>? schools;
  int? currentPage;
  int? totalPages;

  RatingSchoolsModel(
      {this.sId,
      this.userSchoolName,
        this.userSchoolRating,
        this.schools,
        this.currentPage,
        this.totalPages});

  RatingSchoolsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userSchoolName = json['userSchoolName'];
    userSchoolRating = json['userSchoolRating'];
    if (json['schools'] != null) {
      schools = <Schools>[];
      json['schools'].forEach((v) {
        schools!.add(new Schools.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }
}

class Schools {
  String? sId;
  String? schoolName;
  int? rating;

  Schools({this.sId, this.schoolName, this.rating});

  Schools.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    schoolName = json['schoolName'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['schoolName'] = this.schoolName;
    data['rating'] = this.rating;
    return data;
  }
}
