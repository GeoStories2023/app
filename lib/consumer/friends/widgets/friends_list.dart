import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/consumer/friends/views/friend_search.dart';
import 'package:geostories/consumer/friends/widgets/friend_element.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geostories/widgets/page_transitions.dart';

import '../../profile/profile_bloc.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const Divider(),
        friends(context),
      ],
    );
  }

  Widget friends(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(ProfileFriendsLoaded());
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileFriendsLoadSuccess ||
          current is ProfileFriendsLoadInProgress ||
          current is ProfileFriendsLoadError,
      builder: (context, state) {
        if (state is ProfileFriendsLoadSuccess) {
          return Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                state.friends.length,
                (index) => FriendElement(state.friends[index]),
              ),
            ),
          );
        } else if (state is ProfileFriendsLoadInProgress) {
          return Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                5,
                (index) => const FriendElement.skeleton(),
              ),
            ),
          );
        }
        return const Center(
          child: Text("Error loading friends"),
        );
      },
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
          onPressed: () => showDialog(
            context: context,
            builder: (context) => _friendAddPopup(context),
          ),
          icon: const Icon(Icons.add),
          label: const Text("Add friend"),
        ),
      ],
    );
  }

  Widget _friendAddPopup(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Username:"),
            TextField(
              onSubmitted: (v) => controller.text = v,
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => bloc.add(ProfileFriendsAdded(controller.text)),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
