import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../profile_bloc.dart';

class CityDetails extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CityDetails(this.name, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      minHeight: 0,
      onPanelClosed: () => BlocProvider.of<ProfileBloc>(context).add(
        ProfileCityClosed(),
      ),
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      panel: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(imageUrl),
          ),
          Text(name),
        ],
      ),
    );
  }
}
