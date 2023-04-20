import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscoverSouthAmerica extends StatelessWidget {
  const DiscoverSouthAmerica({super.key});

  @override
  Widget build(BuildContext context) {
    const String img = "assets/consumer/map/world-map-suedamerika.svg";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: SafeArea(
        child: Hero(
          tag: "map-southamerica",
          child: SvgPicture.asset(img),
        ),
      ),
    );
  }
}
