import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';

import '../../profile/profile_bloc.dart';

class FriendElement extends StatefulWidget {
  final bool? buildSkeleton;
  final ConsumerFriend? friend;

  const FriendElement(
    this.friend, {
    super.key,
  }) : buildSkeleton = false;

  const FriendElement.skeleton({super.key})
      : buildSkeleton = true,
        friend = null;

  @override
  State<FriendElement> createState() => _FriendElementState();
}

class _FriendElementState extends State<FriendElement> {
  bool showCrud = false;

  @override
  Widget build(BuildContext context) {
    if (widget.buildSkeleton!) {
      return Column(
        children: [
          _imageSkeleton(context),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          _textSkeleton(context),
        ],
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showCrud = false;
        });
      },
      onLongPress: () {
        setState(() {
          showCrud = true;
        });
      },
      child: Stack(children: [
        _friendImage(context),
        if (showCrud) _crud(context),
      ]),
    );
  }

  Widget _crud(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    return IconButton(
      onPressed: () {
        bloc.add(ProfileFriendsRemoved(widget.friend!.uid));
        setState(() {
          showCrud = false;
        });
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _imageSkeleton(BuildContext context) {
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

  Widget _friendImage(BuildContext context) {
    if (widget.friend!.profilePictureUrl.isEmpty) {
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
                  imageUrl: widget.friend!.profilePictureUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => _imageSkeleton(context),
                ),
              ),
            ),
          ],
        ),
        Text(widget.friend!.name),
      ],
    );
  }
}
