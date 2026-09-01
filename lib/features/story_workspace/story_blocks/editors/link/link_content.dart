class LinkContent {
  final String title;
  final String url;

  LinkContent({required this.title, required this.url});

  factory LinkContent.fromJson(Map<String, dynamic> json) {
    return LinkContent(title: json["title"], url: json["url"]);
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "url": url};
  }
}
