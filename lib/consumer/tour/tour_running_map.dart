import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geostories/consumer/tour/models/started_tour_data.dart';
import 'package:geostories/consumer/tour/models/tour_data.dart';
import 'package:geostories/consumer/tour/repositories/i_map_repo.dart';
import 'package:geostories/consumer/tour/repositories/map_rest_repo.dart';
import 'package:geostories/consumer/tour/repositories/map_runtime_repo.dart';
import 'package:geostories/consumer/tour/widgets/tour_map.dart';
import 'package:latlong2/latlong.dart';

import 'models/tour_point.dart';

class TourRunningMap extends StatefulWidget {
  //String startedTourId;
  StartedTour startedTour;

  IMapRepo repo;

  TourRunningMap({super.key, required this.repo, required this.startedTour});

  @override
  State<TourRunningMap> createState() => _TourRunningMapState();
}

class _TourRunningMapState extends State<TourRunningMap> {
  MapController mapController = MapController();
  bool canMove = false;
  LatLng? lastPosition;
  late StreamSubscription positionStream;

  @override
  void initState() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );
    Geolocator.getCurrentPosition().then((value) {
      lastPosition = LatLng(value.latitude, value.longitude);
    });
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((position) {
      try {
        var newPos = LatLng(position.latitude, position.longitude);
        lastPosition = newPos;
        lastPosition = newPos;
        widget.startedTour.tourData.tourPoints
            .where((tourPoint) =>
                !widget.startedTour.visitedTourPointIds.contains(tourPoint.id))
            .forEach(
          (tourPoint) {
            double distance = Geolocator.distanceBetween(
                newPos.latitude,
                newPos.longitude,
                tourPoint.pos.latitude,
                tourPoint.pos.longitude);

            if (distance < 30) {
              widget.repo
                  .setTourpointVisited(widget.startedTour.id, tourPoint.id)
                  .then((startedTour) {
                TourData tourData = widget.startedTour.tourData;
                StartedTour newStartedTour = StartedTour(
                    id: startedTour.id,
                    isCompleted: startedTour.isCompleted,
                    dateStarted: startedTour.dateStarted,
                    dateEnded: startedTour.dateEnded,
                    tourData: tourData,
                    visitedTourPointIds: startedTour.visitedTourPointIds);
                setState(() {
                  widget.startedTour = newStartedTour;
                });
              });
            }
          },
        );
        if (!canMove) {
          mapController.move(newPos, mapController.zoom);
        }
      } catch (e) {
        print(e);
      }
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
      if (tourPoint.type != TourPointType.waypoint) {
        markers.add(tourPoint.marker);
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    //Future<TourData> tourData =
    //widget.repo.getTour("7971b05e-e10c-430e-ba3c-6db1f91bc082");
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          TourMap(
            tourData: Future<TourData>.value(widget.startedTour.tourData),
            centerPosition: LatLng(1, 1),
            startedTour: widget.startedTour,
            mapController: mapController,
            interactiveFlag: canMove
                ? InteractiveFlag.all
                : InteractiveFlag.none |
                    InteractiveFlag.rotate |
                    InteractiveFlag.pinchZoom,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 18),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        canMove = !canMove;
                        if (!canMove && lastPosition != null) {
                          mapController.move(
                              LatLng(lastPosition!.latitude,
                                  lastPosition!.longitude),
                              16);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        canMove ? Icons.lock_open : Icons.lock,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
