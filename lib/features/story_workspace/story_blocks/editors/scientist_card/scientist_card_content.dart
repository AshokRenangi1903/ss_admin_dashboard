class ScientistCardContent {
  final String title;
  final String scientistName;
  final String birth;
  final String death;
  final String imageUrl;
  final List<dynamic> descriptionOps;

  ScientistCardContent({
    required this.birth,
    required this.death,
    required this.imageUrl,
    required this.title,
    required this.scientistName,
    required this.descriptionOps,
  });

  factory ScientistCardContent.fromJson(Map<String, dynamic> json) {
    return ScientistCardContent(
      descriptionOps: List<dynamic>.from(json["descriptionOps"] ?? []),
      title: json["title"],
      birth: json["birth"],
      death: json["death"],
      imageUrl: json["imageUrl"],
      scientistName: json["scientistName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "descriptionOps": descriptionOps,
      "title": title,
      "birth": birth,
      "death": death,
      "imageUrl": imageUrl,
      "scientistName": scientistName,
    };
  }
}
