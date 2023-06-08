import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../position_bloc/bloc/position_bloc.dart';

class CurrentPositionLayer extends StatefulWidget {
  const CurrentPositionLayer({super.key});

  @override
  State<CurrentPositionLayer> createState() => _CurrentPositionLayerState();
}

class _CurrentPositionLayerState extends State<CurrentPositionLayer> {
  late LatLng currentPosition;

  @override
  void initState() {
    var positionBloc = BlocProvider.of<PositionBloc>(context);
    BlocListener<PositionBloc, PositionState>(
      listener: (context, state) {
        if (state is StreamStarted) {
          state.positionStream.listen((position) {
            setState(() {
              currentPosition = LatLng(position.latitude, position.longitude);
              positionBloc.add(NewPosition(currentPosition));
            });
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: currentPosition,
          width: 80,
          height: 80,
          builder: (context) => FlutterLogo(),
        ),
      ],
    );
  }
}
