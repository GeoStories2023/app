import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geostories/bloc/models/consumer_statistics.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';

class ConsumerStatistics extends StatelessWidget {
  const ConsumerStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(ProfileStatisticsLoaded());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            l10n!.consumer_profile_statistics,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Divider(),
        statistics(context),
      ],
    );
  }

  Widget statistics(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is ProfileStatisticsLoadSuccess ||
            current is ProfileStatisticsLoadInProgress,
        builder: (context, state) {
          print("AAAAAAA $state");
          if (state is ProfileStatisticsLoadSuccess) {
            return statisticsElement(context, state.statistics);
          }
          return Container();
        },
      ),
    );
  }

  Widget statisticsElement(BuildContext context, ConsumerStats stats) {
    print("Here $stats");
    return Column(
      children: [
        Text("Tours: ${stats.gamesPlayed}"),
      ],
    );
  }

  Widget citiesStats(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2.2,
      height: 150,
      child: Card(
        color: Colors.green[100],
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, top: 4),
              child: Text(
                "Cities",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget geostoriesStats(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2.2,
      height: 150,
      child: Card(
        color: Colors.green[100],
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, top: 4),
              child: Text(
                "Geostories",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
