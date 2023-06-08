import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/consumer/friends/widgets/friends_list.dart';
import 'package:geostories/consumer/profile/widgets/discounts_list.dart';

import '../../widgets/profile_picture.dart';
import 'profile_bloc.dart';
import 'widgets/city_details.dart';
import 'widgets/city_statistics.dart';
import 'widgets/consumer_statistics.dart';

class ConsumerProfile extends StatelessWidget {
  const ConsumerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 5,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: profileName(context),
                    ),
                  ),
                  const ProfilePicture.withEmail(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  const ConsumerStatistics(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const CityStatistics(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const FriendsList(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const DiscountsList(),
                ],
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) =>
                  current is ProfileViewCityDetails ||
                  current is ProfileHideCityDetails,
              builder: (context, state) {
                if (state is ProfileViewCityDetails) {
                  return CityDetails(state.name, state.imageUrl);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget profileName(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(ProfileNameLoaded());
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileNameLoadSuccess,
      builder: (context, state) {
        if (state is ProfileNameLoadSuccess) {
          return Text(
            "The story of ${state.name},",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          );
        }
        return Container();
      },
    );
  }
}
