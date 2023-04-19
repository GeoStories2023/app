import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AdventureContinueElement extends StatelessWidget {
  final String storyName;
  final String chapterName;
  final double progress;

  const AdventureContinueElement(
    this.storyName, {
    super.key,
    required this.chapterName,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imgWidth = 70;
    return Center(
      child: Container(
        width: width * .8,
        height: 75,
        color: Colors.green[100],
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: imgWidth,
                width: imgWidth,
                child: Image.asset(
                  "assets/city_tour.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
            _adventureInfo(context),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
            _continueAdventureButton(context),
          ],
        ),
      ),
    );
  }

  Widget _adventureInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          storyName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          chapterName,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * .5,
          lineHeight: 7,
          percent: progress,
          progressColor: Colors.red,
        )
      ],
    );
  }

  Widget _continueAdventureButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const FaIcon(
        FontAwesomeIcons.angleRight,
        size: 19,
      ),
    );
  }
}
