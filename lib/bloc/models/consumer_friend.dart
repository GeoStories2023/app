class ConsumerFriend {
  final String name;
  final String profilePictureUrl;

  const ConsumerFriend({
    required this.name,
    required this.profilePictureUrl,
  });

  factory ConsumerFriend.fromJson(Map<String, dynamic> json) {
    return ConsumerFriend(
      name: json['username'],
      profilePictureUrl: "https://companieslogo.com/img/orig/GOOG-0ed88f7c.png",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pictureUrl': profilePictureUrl,
    };
  }
}
