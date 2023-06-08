class CityStat {
  final String cityName;
  final int visitedCount;

  CityStat(this.cityName, this.visitedCount);
}

class CountryStat {
  final String countryName;
  final int visitedCount;

  CountryStat(this.countryName, this.visitedCount);
}

class ContinentStat {
  final String continentName;
  final int visitedCount;

  ContinentStat(this.continentName, this.visitedCount);
}

class ConsumerStats {
  final int gamesPlayed;
  final List<CityStat> visitedCities;
  final List<CountryStat> visitedCountries;
  final List<ContinentStat> visitedContinents;
  final int collectedDiscounts;

  const ConsumerStats({
    required this.gamesPlayed,
    required this.visitedCities,
    required this.collectedDiscounts,
    required this.visitedCountries,
    required this.visitedContinents,
  });

  factory ConsumerStats.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cityJson = json['visitedCities'];
    Map<String, dynamic> countryJson = json['visitedCountries'];
    Map<String, dynamic> continentJson = json['visitedContinents'];

    List<CityStat> cityStats = [];
    List<CountryStat> countryStats = [];
    List<ContinentStat> continentStats = [];

    cityJson.forEach((key, value) => cityStats.add(CityStat(key, value)));
    countryJson
        .forEach((key, value) => countryStats.add(CountryStat(key, value)));
    continentJson
        .forEach((key, value) => continentStats.add(ContinentStat(key, value)));

    return ConsumerStats(
      gamesPlayed: json['toursCount'],
      visitedCities: cityStats,
      visitedCountries: countryStats,
      visitedContinents: continentStats,
      collectedDiscounts: 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'gamesPlayed': gamesPlayed,
        'visitedCities': visitedCities,
      };
}
