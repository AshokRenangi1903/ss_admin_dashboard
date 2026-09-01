class QuotationContent {
  final String quote;
  final String? author;

  QuotationContent({required this.quote, this.author});

  factory QuotationContent.fromJson(Map<String, dynamic> json) {
    return QuotationContent(quote: json["quote"], author: json["author"]);
  }

  Map<String, dynamic> toJson() {
    return {"quote": quote, "author": author};
  }
}
