class TourInfo {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;

  TourInfo({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory TourInfo.fromJson(Map<String, dynamic> json) {
    return TourInfo(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
