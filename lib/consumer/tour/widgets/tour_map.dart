import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geostories/consumer/tour/models/started_tour_data.dart';
import 'package:geostories/consumer/tour/repositories/i_map_repo.dart';
import 'package:geostories/consumer/tour/repositories/map_rest_repo.dart';
import 'package:geostories/consumer/tour/repositories/map_runtime_repo.dart';
import 'package:latlong2/latlong.dart';

import '../destination_popup.dart';
import '../models/tour_data.dart';
import '../models/tour_point.dart';

class TourMap extends StatefulWidget {
  final LatLng? centerPosition;
  final MapController mapController;
  int interactiveFlag;
  Future<TourData> tourData;
  StartedTour? startedTour;
  IMapRepo repo = MapRestRepo("http://192.168.196.127");
  TourMap({
    super.key,
    required this.centerPosition,
    required this.mapController,
    required this.tourData,
    this.startedTour,
    this.interactiveFlag = InteractiveFlag.all,
  });

  @override
  State<TourMap> createState() => _TourMapState();
}

class _TourMapState extends State<TourMap> {
  TourData? tourData;
  LatLng? currentPosition;
  double? heading;
  final PopupController popupLayerController = PopupController();
  late StreamSubscription positionStream;

  @override
  void initState() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((position) {
      heading = position.heading;
      var newPos = LatLng(position.latitude, position.longitude);

      setState(() {
        currentPosition = newPos;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  List<Marker> tourPointToMarker(List<TourPoint> tourPoints) {
    List<Marker> markers = [];
    for (TourPoint tourPoint in tourPoints) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$tourPoint");
      if (tourPoint.type != TourPointType.waypoint) {
        Marker marker = tourPoint.marker;
        if (widget.startedTour != null) {
          if (widget.startedTour!.visitedTourPointIds.contains(tourPoint.id)) {
            marker = TourPoint.createMarker(
                tourPoint.pos, tourPoint.type, Colors.green);
          }
        }
        markers.add(marker);
      }
    }
    return markers;
  }

  Widget markerLayer(TourData data) {
    try {
      return PopupMarkerLayerWidget(
        options: PopupMarkerLayerOptions(
            popupController: popupLayerController,
            markers: tourPointToMarker(data.tourPoints),
            markerRotateAlignment:
                PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker) {
              return DestinationPopup(data.tourPoints.firstWhere(
                  (tourPoint) => tourPoint.marker.point == marker.point));
            }),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.tourData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          tourData = snapshot.data;
          return FlutterMap(
            options: MapOptions(
              interactiveFlags: widget.interactiveFlag,
              onTap: (tapPosition, point) =>
                  popupLayerController.hideAllPopups(),
              center: LatLng(1, 1),
              zoom: 5,
            ),
            mapController: widget.mapController,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                maxNativeZoom: 18,
                maxZoom: 20,
              ),
              currentPosition != null
                  ? MarkerLayer(
                      markers: [
                        Marker(
                          point: currentPosition!,
                          width: 80,
                          height: 80,
                          builder: (context) => Icon(
                            Icons.navigation,
                            size: 60,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              snapshot.data!.tourPoints.length > 1
                  ? PolylineLayer(
                      polylines: [
                        Polyline(
                            points: snapshot.data!.tourPoints
                                .map((tourPoint) => tourPoint.marker.point)
                                .toList(),
                            strokeWidth: 4,
                            color: Colors.blue),
                      ],
                    )
                  : Container(),
              markerLayer(snapshot.data!),
            ],
          );
        });
  }
}
