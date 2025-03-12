class SchoolsModel {
  List<Success>? success;
  List<Success>? classes;

  SchoolsModel({this.success,this.classes});

  SchoolsModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = <Success>[];
      json['success'].forEach((v) {
        success!.add(new Success.fromJson(v));
      });
    }
  }

  SchoolsModel.fromJsonClass(Map<String, dynamic> json) {
    if (json['classes'] != null) {
      classes = <Success>[];
      json['classes'].forEach((v) {
        classes!.add(new Success.fromJson(v));
      });
    }
  }
}

class Success {
  String? sId;
  String? name;

  Success({this.sId, this.name});

  Success.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
