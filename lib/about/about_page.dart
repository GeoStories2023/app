import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geostories/about/widgets/contributor_card.dart';
import 'package:geostories/navpage.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavPage(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * .25,
              backgroundImage: const AssetImage("assets/dev_group_image.jpg"),
            ),
            const Text(
              "GeoStories Team",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.aboutProjectDescription,
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Nils Sterz",
              child: Text(""),
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Noah Thiering",
              child: Text(""),
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Janis Meister",
              child: Text(""),
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Lena Ilsemann",
              child: Text(""),
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Tom Wilke",
              child: Text(""),
            ),
            const ContributorCard(
              image: AssetImage("assets/dev_group_image.jpg"),
              contributorName: "Julius Ewert",
              child: Text(""),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text("Made with Flutter 🚀"),
            ),
          ],
        ),
      ),
    );
  }
}
