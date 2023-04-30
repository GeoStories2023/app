class ConsumerStatistics {
  final int gamesPlayed;
  final List<String> topCities;
  final int collectedDiscounts;

  const ConsumerStatistics({
    required this.gamesPlayed,
    required this.topCities,
    required this.collectedDiscounts,
  });

  factory ConsumerStatistics.fromJson(Map<String, dynamic> json) {
    return ConsumerStatistics(
      gamesPlayed: json['gamesPlayed'],
      topCities: json['topCities'].cast<String>(),
      collectedDiscounts: json['collectedDiscounts'],
    );
  }

  Map<String, dynamic> toJson() => {
        'gamesPlayed': gamesPlayed,
        'topCities': topCities,
        'collectedDiscounts': collectedDiscounts,
      };
}
