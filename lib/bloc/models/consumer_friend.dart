class ConsumerFriend {
  final String uid;
  final String name;
  final String profilePictureUrl;

  const ConsumerFriend({
    required this.uid,
    required this.name,
    required this.profilePictureUrl,
  });

  factory ConsumerFriend.fromJson(Map<String, dynamic> json) {
    return ConsumerFriend(
      uid: json['uid'],
      name: json['username'],
      profilePictureUrl: json['profileImageUrl'] ??
          "https://companieslogo.com/img/orig/GOOG-0ed88f7c.png",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'pictureUrl': profilePictureUrl,
    };
  }
}
