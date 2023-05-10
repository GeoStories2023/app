import 'package:flutter/material.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:geostories/consumer/friends/views/friend_search.dart';
import 'package:geostories/consumer/friends/widgets/friend_element.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geostories/widgets/page_transitions.dart';

class FriendsList extends StatelessWidget {
  final List<ConsumerFriend> _friendModels = const [
    ConsumerFriend(
      name: "nils",
      profilePictureUrl:
          "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
    ),
  ];

  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FriendElement> _friends = [FriendElement(_friendModels[0])];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const Divider(),
        Center(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            // children: _friends,
            children: List.generate(
              5,
              (index) => const FriendElement.skeleton(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            l10n!.consumer_profile_friends,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        TextButton.icon(
          onPressed: () => Navigator.of(context).push(
            slideLeftTransition(const FriendSearch()),
          ),
          icon: const Icon(Icons.add),
          label: const Text("Add friend"),
        ),
      ],
    );
  }
}
