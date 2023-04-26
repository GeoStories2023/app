import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/tour_point.dart';

class DestinationInfoPage extends StatelessWidget {
  final TourPoint tourPoint;
  const DestinationInfoPage(this.tourPoint, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const FaIcon(FontAwesomeIcons.angleLeft),
              ),
            ),
            Text('${tourPoint.description}'),
          ],
        ),
      ),
    );
  }
}
