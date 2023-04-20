import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories_app/auth/auth.dart';
import 'package:geostories_app/consumer/profile/profile_bloc.dart';
import 'package:geostories_app/consumer/profile/widgets/city_details.dart';
import 'package:geostories_app/consumer/profile/widgets/consumer_statistics.dart';
import 'package:geostories_app/consumer/profile/widgets/leaderboard.dart';

import '../../widgets/profile_picture.dart';
import 'widgets/city_statistics.dart';

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
                      child: Text(
                        "The story of ${AuthService().currentUser!.displayName},",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const ProfilePicture.withEmail(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  const ConsumerStatistics(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const CityStatistics(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const Leaderboard(),
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
}
