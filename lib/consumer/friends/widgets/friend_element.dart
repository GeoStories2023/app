import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';

class FriendElement extends StatelessWidget {
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
    return _friendImage(context);
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

  Widget _friendImage(BuildContext context) {
    if (friend!.profilePictureUrl.isEmpty) {
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
                  imageUrl: friend!.profilePictureUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => _citySkeleton(context),
                ),
              ),
            ),
          ],
        ),
        Text(friend!.name),
      ],
    );
  }
}
