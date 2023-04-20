import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/page_transitions.dart';
import '../pages/discover_africa.dart';
import '../pages/discover_asia.dart';
import '../pages/discover_europe.dart';
import '../pages/discover_north_america.dart';
import '../pages/discover_oceania.dart';
import '../pages/discover_south_america.dart';

class DiscoverWorldMap extends StatelessWidget {
  const DiscoverWorldMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 2,
        height: MediaQuery.of(context).size.height * .5,
        child: Stack(
          children: [
            _europe(context),
            _afrika(context),
            _southAmerika(context),
            _northAmerika(context),
            _oceania(context),
            _asia(context),
          ],
        ),
      ),
    );
  }

  Widget _oceania(BuildContext context) {
    const String img = "assets/consumer/map/world-map-ozeanien.svg";
    return _continent(
      context,
      img: img,
      page: const DiscoverOceania(),
      tag: "map-oceania",
      bottom: 40,
      left: 350,
    );
  }

  Widget _northAmerika(BuildContext context) {
    const String img = "assets/consumer/map/world-map-nordamerika.svg";
    return _continent(
      context,
      img: img,
      tag: "map-northamerica",
      page: const DiscoverNorthAmerica(),
      bottom: 200,
    );
  }

  Widget _southAmerika(BuildContext context) {
    const String img = "assets/consumer/map/world-map-suedamerika.svg";
    return _continent(
      context,
      img: img,
      tag: "map-southamerica",
      page: const DiscoverSouthAmerica(),
      bottom: 60,
      left: 100,
    );
  }

  Widget _afrika(BuildContext context) {
    const String img = "assets/consumer/map/world-map-afrika.svg";
    return _continent(
      context,
      img: img,
      tag: "map-africa",
      page: const DiscoverAfrica(),
      left: 200,
      bottom: 90,
    );
  }

  Widget _asia(BuildContext context) {
    const String img = "assets/consumer/map/world-map-asien.svg";
    return _continent(
      context,
      img: img,
      tag: "map-asia",
      page: const DiscoverAsia(),
      top: 100,
      left: 350,
    );
  }

  Widget _europe(BuildContext context) {
    const String img = "assets/consumer/map/world-map-europa.svg";
    return _continent(
      context,
      img: img,
      tag: "map-europe",
      page: const DiscoverEurope(),
      top: 100,
      left: 230,
    );
  }

  Widget _continent(
    BuildContext context, {
    required String img,
    required Widget page,
    required String tag,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      right: right,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(slideLeftTransition(page)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(tag: tag, child: SvgPicture.asset(img)),
            const FaIcon(
              FontAwesomeIcons.locationArrow,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
