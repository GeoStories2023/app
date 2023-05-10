class ConsumerFriend {
  final String name;
  final String profilePictureUrl;

  const ConsumerFriend({
    required this.name,
    required this.profilePictureUrl,
  });

  factory ConsumerFriend.fromJson(Map<String, dynamic> json) {
    return ConsumerFriend(
      name: json['name'],
      profilePictureUrl: json['pictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pictureUrl': profilePictureUrl,
    };
  }
}
