class ImageContent {
  String title;
  final String imageUrl;
  final List<dynamic> captionOps;

  ImageContent({
    required this.imageUrl,
    required this.captionOps,
    required this.title,
  });

  factory ImageContent.fromJson(Map<String, dynamic> json) {
    return ImageContent(
      imageUrl: json["imageUrl"],
      captionOps: List<dynamic>.from(json["captionOps"] ?? []),
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"imageUrl": imageUrl, "captionOps": captionOps, "title": title};
  }
}
