class ArticleModel {
  String id;
  String title;
  String body;

  ArticleModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory ArticleModel.fromMap(dynamic map) {
    return ArticleModel(
      id: map["id"] ?? "id",
      title: map["title"] ?? "title",
      body: map["body"] ?? "body",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
