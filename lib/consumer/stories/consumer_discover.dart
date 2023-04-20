import 'package:flutter/material.dart';

import 'widgets/discover_world_map.dart';

class ConsumerDiscover extends StatelessWidget {
  const ConsumerDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _title(context),
            const DiscoverWorldMap(),
          ],
        ),
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
