import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import '../destination_popup.dart';
import '../models/tour_point.dart';
import '../preview_bloc/preview_bloc.dart';

class TourPopupLayer extends StatelessWidget {
  TourPopupLayer({super.key});

  List<Marker> tourPointToMarker(List<TourPoint> tourPoints) {
    List<Marker> markers = [];
    for (TourPoint tourPoint in tourPoints) {
      if (tourPoint.type != TourPointType.waypoint) {
        markers.add(tourPoint.marker);
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<PreviewBloc>(context);
    return BlocBuilder<PreviewBloc, PreviewState>(
      buildWhen: (previous, current) => current is PreviewLoaded,
      builder: (context, state) {
        if (state is PreviewLoaded) {
          return PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              popupController: bloc.popupLayerController,
              markers: tourPointToMarker(state.data.tourPoints),
              markerRotateAlignment:
                  PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) =>
                  DestinationPopup(
                state.data.tourPoints
                    .firstWhere((tourPoint) => tourPoint.marker == marker),
              ),
            ),
          );
        }
        return const CircularProgressIndicator(color: Colors.orange);
      },
    );
  }
}
