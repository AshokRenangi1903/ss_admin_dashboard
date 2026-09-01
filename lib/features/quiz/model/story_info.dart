class StoryInfo {
  String? title;
  EraInfo? era;

  StoryInfo({this.title, this.era});

  StoryInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];

    era = json['era'] != null ? EraInfo.fromJson(json['era']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['title'] = title;

    if (era != null) {
      data['era'] = era!.toJson();
    }

    return data;
  }
}

class EraInfo {
  String? title;
  String? id;
  EraInfo({this.title, this.id});

  EraInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['title'] = title;
    data['id'] = id;

    return data;
  }
}
