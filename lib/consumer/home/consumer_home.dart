import 'package:flutter/material.dart';

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
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: ProfileHeader(),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              NewsList(),
              Padding(padding: EdgeInsets.only(top: 10)),
              AdventureContinueList(),
              Padding(padding: EdgeInsets.only(top: 10)),
              PremiumCard(),
            ],
          ),
        ),
      ),
    );
  }
}
