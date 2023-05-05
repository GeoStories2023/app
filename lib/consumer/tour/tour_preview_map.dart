import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geostories/consumer/tour/preview_bloc/preview_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'destination_popup.dart';
import 'models/tour_point.dart';

class TourPreviewMap extends StatefulWidget {
  const TourPreviewMap({Key? key}) : super(key: key);

  @override
  State<TourPreviewMap> createState() => _TourPreviewMapState();
}

class _TourPreviewMapState extends State<TourPreviewMap> {
  late Future<List<Polyline>> polylines;
  final PopupController _popupLayerController = PopupController();

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
  void initState() {
    polylines = Future.value([
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ElevatedButton(
              onPressed: () =>
                  context.read<PreviewBloc>()..add(const LoadPreview()),
              child: const Text('Looks like a RaisedButton')),
        ),
        body: BlocBuilder<PreviewBloc, PreviewState>(
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
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text('Polylines'),
                          ),
                          Flexible(
                            child: FlutterMap(
                              options: MapOptions(
                                onTap: (tapPosition, point) =>
                                    _popupLayerController.hideAllPopups(),
                                center: LatLng(51.5, -0.09),
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
                                            .map((tourPoint) => tourPoint.pos)
                                            .toList(),
                                        strokeWidth: 4,
                                        color: Colors.purple),
                                  ],
                                ),
                                PopupMarkerLayerWidget(
                                  options: PopupMarkerLayerOptions(
                                    popupController: _popupLayerController,
                                    markers: tourPointToMarker(
                                        state.data.tourPoints),
                                    markerRotateAlignment:
                                        PopupMarkerLayerOptions
                                            .rotationAlignmentFor(
                                                AnchorAlign.top),
                                    popupBuilder:
                                        (BuildContext context, Marker marker) =>
                                            DestinationPopup(
                                      state.data.tourPoints.firstWhere(
                                          (tourPoint) =>
                                              tourPoint.marker == marker),
                                    ),
                                  ),
                                ),
                                // MarkerLayer(markers: state.data.markers),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text(
                        'Getting map data...\n\nTap on map when complete to refresh map data.');
                  },
                ),
              );
            } else {
              return const CircularProgressIndicator(color: Colors.orange);
            }
          },
        ));
  }
}
