import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geostories/consumer/tour/position_bloc/bloc/position_bloc.dart';
import 'package:geostories/consumer/tour/preview_bloc/preview_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../auth/auth_service.dart';
import 'destination_popup.dart';
import 'models/tour_point.dart';

class TourPreviewMap extends StatelessWidget {
  late Future<List<Polyline>> polylines = Future.value([
    Polyline(
      points: [
        LatLng(50.5, -0.09),
        LatLng(51.3498, -6.2603),
        LatLng(53.8566, 2.3522),
      ],
      strokeWidth: 50,
      color: Colors.amber,
    ),
  ]);
  final PopupController _popupLayerController = PopupController();

  TourPreviewMap({super.key});

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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
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
                SizedBox(
                  height: 300,
                  child: BlocBuilder<PreviewBloc, PreviewState>(
                    buildWhen: (previous, current) => current is PreviewLoaded,
                    builder: (context, state) {
                      if (state is PreviewLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder<List<Polyline>>(
                            future: polylines,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Polyline>> snapshot) {
                              debugPrint('snapshot: ${snapshot.hasData}');
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 40, bottom: 8),
                                    ),
                                    Flexible(
                                      child: FlutterMap(
                                        options: MapOptions(
                                          onTap: (tapPosition, point) =>
                                              _popupLayerController
                                                  .hideAllPopups(),
                                          center: LatLng(51.5, 10.09),
                                          zoom: 5,
                                        ),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'dev.fleaflet.flutter_map.example',
                                          ),
                                          PolylineLayer(
                                            polylines: [
                                              Polyline(
                                                  points: state.data.tourPoints
                                                      .map((tourPoint) =>
                                                          tourPoint
                                                              .marker.point)
                                                      .toList(),
                                                  strokeWidth: 4,
                                                  color: Colors.blue),
                                            ],
                                          ),
                                          BlocBuilder<PositionBloc,
                                                  PositionState>(
                                              builder: (context, state) {
                                            if (state is NewPlayerPosition) {
                                              return MarkerLayer(
                                                markers: [
                                                  Marker(
                                                    point: state.position,
                                                    width: 80,
                                                    height: 80,
                                                    builder: (context) =>
                                                        FlutterLogo(),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          }),
                                          PopupMarkerLayerWidget(
                                            options: PopupMarkerLayerOptions(
                                              popupController:
                                                  _popupLayerController,
                                              markers: tourPointToMarker(
                                                  state.data.tourPoints),
                                              markerRotateAlignment:
                                                  PopupMarkerLayerOptions
                                                      .rotationAlignmentFor(
                                                          AnchorAlign.top),
                                              popupBuilder:
                                                  (BuildContext context,
                                                          Marker marker) =>
                                                      DestinationPopup(
                                                state.data.tourPoints
                                                    .firstWhere((tourPoint) =>
                                                        tourPoint.marker ==
                                                        marker),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const Text(
                                'Getting map data...\n\nTap on map when complete to refresh map data.',
                              );
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator(
                            color: Colors.orange);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
