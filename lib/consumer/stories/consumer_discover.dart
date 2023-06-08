import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../repositories/i_tour_repo.dart';
import '../../repositories/tour_rest_repo.dart';
import '../../widgets/page_transitions.dart';
import '../tour/models/tour_info.dart';
import '../tour/tour_preview_map.dart';
import 'widgets/discover_world_map.dart';

class ConsumerDiscover extends StatelessWidget {
  const ConsumerDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _title(context),
              const DiscoverWorldMap(),
              _tourWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tourWidget(BuildContext context) {
    final ITourRepo tourRepo = TourRestRepo("http://192.168.43.127:81/api/v1");
    return FutureBuilder(
      future: tourRepo.getTours(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _tourList(context, snapshot.data ?? []);
        }
        return Container();
      },
    );
  }

  Widget _tourList(BuildContext context, List<TourInfo> tours) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          var t = tours[index];
          return ListTile(
            title: Text(t.id),
            leading: Image.network(
              t.imageUrl ??
                  "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(slideLeftTransition(TourPreviewMap(tourId: t.id)));
              },
              icon: const FaIcon(FontAwesomeIcons.angleRight),
            ),
            subtitle: Text(t.description ?? ""),
          );
        },
      ),
    );
  }

  Widget _title(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 5,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Where would you like to go?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
