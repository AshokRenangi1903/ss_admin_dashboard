class StoryModel {
  String? id;
  String? eraId;
  String? title;
  String? description;
  List<String>? scientistNames;
  String? imageUrl;
  int? position;
  bool? isPopular;
  bool? isPublished;
  String? discipline;
  String? subject;
  String? geolocation;
  String? estimatedReadTime;
  String? createdAt;
  String? updatedAt;
  Era? era;

  StoryModel({
    this.id,
    this.eraId,
    this.title,
    this.description,
    this.scientistNames,
    this.imageUrl,
    this.position,
    this.isPopular,
    this.isPublished,
    this.discipline,
    this.subject,
    this.geolocation,
    this.estimatedReadTime,
    this.createdAt,
    this.updatedAt,
    this.era,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eraId = json['eraId'];
    title = json['title'];
    description = json['description'];
    scientistNames = json['scientistNames'].cast<String>();
    imageUrl = json['imageUrl'];
    position = json['position'];
    isPopular = json['isPopular'];
    isPublished = json['isPublished'];
    discipline = json['discipline'];
    subject = json['subject'];
    geolocation = json['geolocation'];
    estimatedReadTime = json['estimatedReadTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    era = json['era'] != null ? new Era.fromJson(json['era']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eraId'] = this.eraId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['scientistNames'] = this.scientistNames;
    data['imageUrl'] = this.imageUrl;
    data['position'] = this.position;
    data['isPopular'] = this.isPopular;
    data['isPublished'] = this.isPublished;
    data['discipline'] = this.discipline;
    data['subject'] = this.subject;
    data['geolocation'] = this.geolocation;
    data['estimatedReadTime'] = this.estimatedReadTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.era != null) {
      data['era'] = this.era!.toJson();
    }
    return data;
  }
}

class Era {
  String? id;
  String? title;

  Era({this.id, this.title});

  Era.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
