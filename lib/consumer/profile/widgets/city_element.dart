import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../profile_bloc.dart';

enum CityRank {
  first,
  second,
  third,
}

class CityElement extends StatelessWidget {
  final bool? buildSkeleton;
  final String? name;
  final CityRank? rank;
  final String? imageUrl;

  const CityElement(
    this.name, {
    super.key,
    this.rank,
    this.imageUrl,
  }) : buildSkeleton = false;

  const CityElement.skeleton({super.key})
      : name = null,
        rank = null,
        buildSkeleton = true,
        imageUrl = null;

  @override
  Widget build(BuildContext context) {
    if (buildSkeleton!) {
      return Column(
        children: [
          _citySkeleton(context),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          _textSkeleton(context),
        ],
      );
    }
    return GestureDetector(
      onTap: () => BlocProvider.of<ProfileBloc>(context).add(
        ProfileCitySelected(name!, imageUrl!),
      ),
      child: _cityImage(context),
    );
  }

  Widget _citySkeleton(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 75,
            height: 75,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _textSkeleton(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 70,
            height: 10,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _cityImage(BuildContext context) {
    if (imageUrl == null) {
      return Image.asset(
        "assets/logo_crop.png",
        fit: BoxFit.fill,
      );
    }

    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 75,
                height: 75,
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => _citySkeleton(context),
                ),
              ),
            ),
            if (rank != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: _getMedal(),
              ),
          ],
        ),
        Text(name!),
      ],
    );
  }

  Widget _getMedal() {
    Color medalColor;

    switch (rank!) {
      case CityRank.first:
        medalColor = Colors.yellow;
        break;
      case CityRank.second:
        medalColor = Colors.grey;
        break;
      case CityRank.third:
        medalColor = Colors.brown;
        break;
    }

    return FaIcon(
      FontAwesomeIcons.medal,
      color: medalColor,
    );
  }
}
