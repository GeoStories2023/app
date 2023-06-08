import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';
import 'package:geostories/repositories/i_consumer_repo.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../auth/auth_service.dart';
import '../../widgets/profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(ProfileNameLoaded());
    bloc.add(ProfileLevelLoaded());
    return Row(
      children: [
        const ProfilePicture(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    current is ProfileNameLoadSuccess,
                builder: (context, state) {
                  if (state is ProfileNameLoadSuccess) {
                    return Text(
                      state.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(AuthService().currentUser?.email ?? ""),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2)),
            _level(context),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _premiumSymbol(context, bloc.consumerRepo),
        ),
      ],
    );
  }

  Widget _premiumSymbol(BuildContext context, IConsumerRepo repo) {
    return FutureBuilder(
      future: repo.isPremium(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return SvgPicture.asset(
              "assets/premium_globus.svg",
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width,
              height: 50,
            );
          }
        }
        return Container();
      },
    );
  }

  Widget _level(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileLevelLoadSuccess,
      builder: (context, state) {
        if (state is ProfileLevelLoadSuccess) {
          return LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * .65,
            progressColor: Colors.purple,
            lineHeight: 15,
            percent: state.level / 100,
          );
        }
        // TODO: Display shimmer.
        return LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * .65,
          progressColor: Colors.purple,
          lineHeight: 15,
          percent: .6,
        );
      },
    );
  }
}
