class Achievement {
  final String name;
  final String description;

  const Achievement({required this.name, required this.description});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
