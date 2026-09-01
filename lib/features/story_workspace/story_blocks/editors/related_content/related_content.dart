class RelatedContent {
  final String section;
  final List<dynamic> ops;

  RelatedContent({required this.section, required this.ops});

  factory RelatedContent.fromJson(Map<String, dynamic> json) {
    return RelatedContent(
      section: json["section"],
      ops: List<dynamic>.from(json["ops"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {"section": section, "ops": ops};
  }
}
