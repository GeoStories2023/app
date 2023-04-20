import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConsumerStatistics extends StatelessWidget {
  const ConsumerStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            l10n!.consumer_profile_statistics,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2.2,
                height: 150,
                child: Card(
                  color: Colors.green[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          "Geostories",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width / 2.2,
                height: 150,
                child: Card(
                  color: Colors.green[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          "Cities",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
