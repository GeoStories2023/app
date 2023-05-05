import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../widgets/page_transitions.dart';
import 'destination_info_page.dart';
import 'models/tour_point.dart';

class DestinationPopup extends StatelessWidget {
  final TourPoint tourPoint;

  const DestinationPopup(this.tourPoint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(slideLeftTransition(DestinationInfoPage(tourPoint)));
        },
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Icon(
                  Icons.push_pin,
                ),
              ),
              _cardDescription(context),
            ],
          ),
        ));
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              tourPoint.name,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              tourPoint.description,
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Position: ${tourPoint.marker.point.latitude}, ${tourPoint.marker.point.longitude}',
              style: const TextStyle(fontSize: 9.0),
            ),
          ],
        ),
      ),
    );
  }
}
