class News {
  final String title;
  final String content;

  const News({required this.title, required this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };
}
