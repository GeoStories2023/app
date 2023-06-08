import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geostories/consumer/tour/repositories/i_map_repo.dart';
import 'package:geostories/consumer/tour/repositories/map_rest_repo.dart';
import 'package:geostories/consumer/tour/tour_running_map.dart';
import 'package:geostories/consumer/tour/widgets/tour_map.dart';
import 'package:latlong2/latlong.dart';

import '../../widgets/page_transitions.dart';
import 'models/started_tour_data.dart';
import 'models/tour_data.dart';
import 'models/tour_point.dart';

class TourPreviewMap extends StatefulWidget {
  final String tourId;
  final String url = "http://192.168.43.127";
  const TourPreviewMap({super.key, required this.tourId});

  @override
  State<TourPreviewMap> createState() => _TourPreviewMapState();
}

class _TourPreviewMapState extends State<TourPreviewMap> {
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
        if (!canMove) {
          var pos = LatLng(position.latitude, position.longitude);
          lastPosition = pos;
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
    //IMapRepo repo = RuntimeRepo();
    IMapRepo repo = MapRestRepo(widget.url);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            FutureBuilder(
              //"7971b05e-e10c-430e-ba3c-6db1f91bc082"
              future: repo.getTour(widget.tourId),
              builder:
                  (BuildContext context, AsyncSnapshot<TourData> snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.angleLeft),
                      ),
                    ),
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Text("Story of Bremen",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: TourMap(
                          tourData: Future.value(snapshot.data),
                          mapController: mapController,
                          centerPosition: LatLng(1, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  repo.getStartedTours().then((value) {
                                    StartedTour? startedTour;
                                    if (value.isNotEmpty) {
                                      startedTour = value.firstWhere(
                                          (element) =>
                                              element.tourData.id ==
                                              snapshot.data?.id);
                                      Navigator.of(context).push(
                                          slideLeftTransition(TourRunningMap(
                                        startedTour: startedTour,
                                        repo: repo,
                                      )));
                                    } else {
                                      repo.startTour(snapshot.data!.id).then(
                                          (value) => Navigator.of(context).push(
                                                  slideLeftTransition(
                                                      TourRunningMap(
                                                startedTour: value,
                                                repo: repo,
                                              ))));
                                    }
                                  });
                                },
                                child: const Text("Start Tour")),
                            const Text(
                              "Beschreibung",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data!.description,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geostories/consumer/tour/position_bloc/bloc/position_bloc.dart';
// import 'package:geostories/consumer/tour/widgets/tour_current_position_layer.dart';
// import 'package:geostories/consumer/tour/widgets/tour_map.dart';
// import 'package:geostories/consumer/tour/widgets/tour_path_layer.dart';
// import 'package:geostories/consumer/tour/widgets/tour_popup_layer.dart';
// import 'package:latlong2/latlong.dart';

// import 'models/tour_point.dart';

// class TourPreviewMap extends StatelessWidget {
//   MapController mapController = MapController();

//   TourPreviewMap({super.key});

//   List<Marker> tourPointToMarker(List<TourPoint> tourPoints) {
//     List<Marker> markers = [];
//     for (TourPoint tourPoint in tourPoints) {
//       if (tourPoint.type != TourPointType.waypoint) {
//         markers.add(tourPoint.marker);
//       }
//     }
//     return markers;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           alignment: AlignmentDirectional.topCenter,
//           children: [
//             Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const FaIcon(FontAwesomeIcons.angleLeft),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.topCenter,
//                     child: Text("Story of Bremen",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold))),
//                 SizedBox(
//                   height: 300,
//                   child: BlocBuilder<PositionBloc, PositionState>(
//                       builder: (context, state) {
//                     if (state is NewPlayerPosition) {
//                       TourMap(
//                         mapController: mapController,
//                         centerPosition: LatLng(1, 1),
//                       );
//                     }
//                     return Container();
//                   }),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
