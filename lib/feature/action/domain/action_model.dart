import '../../dashboard/domain/dashboard_model.dart';

class ActionsModel {
  List<Surveys>? surveys;
  List<Events>? events;
  List<Discussion>? schoolDiscussions;
  List<Discussion>? globalDiscussions;

  ActionsModel({this.surveys, this.events});

  ActionsModel.fromJson(Map<String, dynamic> json) {
    if (json['surveys'] != null) {
      surveys = <Surveys>[];
      json['surveys'].forEach((v) {
        surveys!.add(new Surveys.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    if (json['discussionsSchool'] != null) {
      schoolDiscussions = <Discussion>[];
      json['discussionsSchool'].forEach((v) {
        schoolDiscussions!.add(new Discussion.fromJson(v));
      });
    }
    if (json['discussionsGlobal'] != null) {
      globalDiscussions = <Discussion>[];
      json['discussionsGlobal'].forEach((v) {
        globalDiscussions!.add(new Discussion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.surveys != null) {
      data['surveys'] = this.surveys!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Surveys {
  String? sId;
  String? name;
  String? description;
  List<Options>? options;

  Surveys({this.sId, this.name, this.description, this.options});

  Surveys.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? sId;
  String? title;
  String? description;
  String? date;

  Events({this.sId, this.title, this.description, this.date});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    return data;
  }
}

class Discussion {
  String? sId;
  String? title;
  String? description;

  Discussion({this.sId, this.title, this.description});

  Discussion.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

