class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content; // ✅ New field

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content, // ✅ Add to constructor
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '', // ✅ Add from JSON
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'content': content, // ✅ Include in serialization
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;
}
