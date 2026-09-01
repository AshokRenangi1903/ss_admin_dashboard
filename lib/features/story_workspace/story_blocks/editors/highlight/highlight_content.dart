class HighlightContent {
  final String title;
  final List<dynamic> descriptionOps;

  HighlightContent({required this.descriptionOps, required this.title});

    factory HighlightContent.fromJson(Map<String, dynamic> json) {
      return HighlightContent(
        descriptionOps: List<dynamic>.from(json["descriptionOps"] ?? []),
        title: json["title"],
      );
    }

  Map<String, dynamic> toJson() {
    return {"descriptionOps": descriptionOps, "title": title};
  }
}
