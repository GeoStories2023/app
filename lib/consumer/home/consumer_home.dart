import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/profile_header.dart';
import 'widgets/adventure_continue_list.dart';
import 'widgets/news_list.dart';
import 'widgets/premium.dart';

class ConsumerHome extends StatelessWidget {
  const ConsumerHome({super.key});

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(
                "assets/premium_ad_banner.svg",
                width: MediaQuery.of(context).size.width,
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const AdventureContinueList(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const PremiumCard(),
            ],
          ),
        ),
      ),
    );
  }
}
