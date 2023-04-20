import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'city_element.dart';

class CityStatistics extends StatelessWidget {
  const CityStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    List<CityElement> _cities = [
      const CityElement(
        "Wicker",
        imageUrl:
            "https://kinosommer-hessen.de/wp-content/uploads/2019/05/20110509_d3r_5253_preview.jpg",
        rank: CityRank.first,
      ),
      const CityElement(
        "Wiesbaden",
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/e/e8/Kurhaus_Wiesbaden_blaue_Stunde_290-L4.jpg",
        rank: CityRank.second,
      ),
      const CityElement(
        "Frankfurt",
        imageUrl:
            "https://www.hessen-tourismus.de/fileadmin/hessen-tourismus/03_Starke_Staedte/Frankfurt_am_Main_Neu/Frankfurt_sunset_with_lights___2_of_2__%40mindz.eye_Michael_Sidofsky.jpg",
        rank: CityRank.third,
      ),
      const CityElement(
        "Bremen",
        imageUrl:
            "https://www.bremen-tourismus.de/_Resources/Persistent/0eb8390f610f343b3dc90c9d5e3182a18e4b67c1/bremen-roland-1280x640.jpg",
      ),
      const CityElement(
        "Bremerhaven",
        imageUrl:
            "https://www.butenunbinnen.de/bilder/dpa-16194~_v-1280x720_c-1663779972843.jpg",
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            l10n!.consumer_profile_city_rank,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Divider(),
        Center(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _cities,
            // children: List.generate(
            //   5,
            //   (index) => const CityElement.skeleton(),
            // ),
          ),
        ),
      ],
    );
  }
}
