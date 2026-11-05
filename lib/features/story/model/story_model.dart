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
  List<String>? keywords;

  // Dashboard display names <-> Prisma enum identifiers.
  static const Map<String, String> _subjectToEnum = {
    'Physics': 'PHYSICS',
    'Chemistry': 'CHEMISTRY',
    'Biology': 'BIOLOGY',
    'Medicine': 'MEDICINE',
    'Astronomy & Space': 'ASTRONOMY_SPACE',
    'Earth & Environment': 'EARTH_ENVIRONMENT',
    'Mathematics': 'MATHEMATICS',
    'Computer Science': 'COMPUTER_SCIENCE',
    'Materials & Technology': 'MATERIALS_TECHNOLOGY',
  };

  static final Map<String, String> _enumToSubject = {
    for (final entry in _subjectToEnum.entries) entry.value: entry.key,
  };

  static String? _toDisplaySubject(dynamic value) {
    if (value == null) return null;

    final subject = value.toString();
    return _enumToSubject[subject] ?? subject;
  }

  static String? _toApiSubject(String? value) {
    if (value == null) return null;

    return _subjectToEnum[value] ?? value;
  }

  StoryModel({
    this.id,
    this.eraId,
    this.title,
    this.description,
    this.scientistNames,
    this.keywords,
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

    keywords =
        (json['keywords'] as List?)?.map((e) => e.toString()).toList() ?? [];

    scientistNames =
        (json['scientistNames'] as List?)?.map((e) => e.toString()).toList() ??
        [];

    imageUrl = json['imageUrl'];
    position = json['position'];
    isPopular = json['isPopular'];
    isPublished = json['isPublished'];
    discipline = json['discipline'];

    subject = _toDisplaySubject(json['subject']);

    geolocation = json['geolocation'];
    estimatedReadTime = json['estimatedReadTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    era = json['era'] != null ? Era.fromJson(json['era']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['eraId'] = eraId;
    data['title'] = title;
    data['description'] = description;
    data['scientistNames'] = scientistNames;
    data['keywords'] = keywords;
    data['imageUrl'] = imageUrl;
    data['position'] = position;
    data['isPopular'] = isPopular;
    data['isPublished'] = isPublished;
    data['discipline'] = discipline;

    data['subject'] = _toApiSubject(subject);

    data['geolocation'] = geolocation;
    data['estimatedReadTime'] = estimatedReadTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    if (era != null) {
      data['era'] = era!.toJson();
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
