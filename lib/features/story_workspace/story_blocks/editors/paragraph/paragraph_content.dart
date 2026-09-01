class ParagraphContent {
  final List<dynamic> ops;

  ParagraphContent({required this.ops});

  factory ParagraphContent.fromJson(Map<String, dynamic> json) {
    return ParagraphContent(ops: List<dynamic>.from(json["ops"]));
  }

  Map<String, dynamic> toJson() {
    return {"ops": ops};
  }
}
