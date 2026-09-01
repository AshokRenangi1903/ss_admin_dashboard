class EraModel {
  String? id;
  String? title;
  String? description;
  String? startYear;
  String? endYear;
  String? imageUrl;
  bool? isPublished;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;

  int? storiesCount;

  EraModel({
    this.id,
    this.title,
    this.description,
    this.startYear,
    this.endYear,
    this.imageUrl,
    this.isPublished,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.storiesCount,
  });

  EraModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    imageUrl = json['imageUrl'];
    isPublished = json['isPublished'];
    position = json['position'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    storiesCount = json['_count']?['stories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['startYear'] = startYear;
    data['endYear'] = endYear;
    data['imageUrl'] = imageUrl;
    data['isPublished'] = isPublished;
    data['position'] = position;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['storiesCount'] = storiesCount;
    return data;
  }
}
