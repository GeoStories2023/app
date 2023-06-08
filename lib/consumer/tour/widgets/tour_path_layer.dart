import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../preview_bloc/preview_bloc.dart';

class TourPathLayer extends StatelessWidget {
  const TourPathLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewBloc, PreviewState>(
      buildWhen: (previous, current) => current is PreviewLoaded,
      builder: (context, state) {
        if (state is PreviewLoaded) {
          return PolylineLayer(
            polylines: [
              Polyline(
                  points: state.data.tourPoints
                      .map((tourPoint) => tourPoint.marker.point)
                      .toList(),
                  strokeWidth: 4,
                  color: Colors.blue),
            ],
          );
        } else {
          return PolylineLayer();
        }
      },
    );
  }
}
