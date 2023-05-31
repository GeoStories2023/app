import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../auth/auth_service.dart';
import '../../widgets/profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(ProfileNameLoaded());
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
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * .65,
              progressColor: Colors.purple,
              lineHeight: 15,
              percent: .6,
            ),
          ],
        ),
      ],
    );
  }
}
