import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';

import '../../repositories/i_tour_repo.dart';
import '../../repositories/tour_rest_repo.dart';
import '../widgets/profile_header.dart';
import 'widgets/adventure_continue_list.dart';
import 'widgets/news_list.dart';

class ConsumerHome extends StatelessWidget {
  const ConsumerHome({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: ProfileHeader(),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const NewsList(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              FutureBuilder(
                future: bloc.consumerRepo.isPremium(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == false) {
                      return SvgPicture.asset(
                        "assets/premium_ad_banner.svg",
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                      );
                    }
                  }
                  return Container();
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const AdventureContinueList(),
            ],
          ),
        ),
      ),
    );
  }
}
