import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';

import 'profile/consumer_profile.dart';
import 'home/consumer_home.dart';
import 'stories/consumer_discover.dart';

class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _ConsumerHomePage();
}

class _ConsumerHomePage extends State<ConsumerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ConsumerHome(),
    ConsumerDiscover(),
    ConsumerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigate,
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.home),
            label: l10n!.nav_home,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.compass),
            label: l10n.nav_discover,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.userAlt),
            label: l10n.nav_profile,
          ),
        ],
      ),
    );
  }

  _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
