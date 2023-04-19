import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscoverEurope extends StatelessWidget {
  const DiscoverEurope({super.key});

  @override
  Widget build(BuildContext context) {
    const String img = "assets/consumer/map/world-map-europa.svg";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: SafeArea(
        child: Hero(
          tag: "map-europe",
          child: SvgPicture.asset(img),
        ),
      ),
    );
  }
}
