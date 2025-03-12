class NotificationModel {
  List<Notifications>? notifications;
  int? total;
  int? page;
  int? limit;
  int? pages;

  NotificationModel(
      {this.notifications, this.total, this.page, this.limit, this.pages});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['pages'] = this.pages;
    return data;
  }
}

class Notifications {
  String? sId;
  String? title;
  String? body;
  String? type;
  String? createdAt;

  Notifications({this.sId, this.title, this.body, this.type, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
