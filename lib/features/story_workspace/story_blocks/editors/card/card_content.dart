class CardContent {
  final String title;
  final String description;

  CardContent({required this.title, required this.description});

  factory CardContent.fromJson(Map<String, dynamic> json) {
    return CardContent(title: json["title"], description: json["description"]);
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description};
  }
}
