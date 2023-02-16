import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'about/about_page.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';

int selectedIndex = 0;

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 10);
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          NavItem(
            page: CustomPageRoute(builder: (context) => const HomePage()),
            index: 0,
            text: AppLocalizations.of(context)!.navBarHome,
            leading: const FaIcon(FontAwesomeIcons.house),
          ),
          const Divider(
            color: Colors.black,
          ),
          NavItem(
            leading: const FaIcon(FontAwesomeIcons.gear),
            index: 5,
            text: AppLocalizations.of(context)!.navBarSettings,
            page: CustomPageRoute(builder: (context) => const SettingsPage()),
          ),
          NavItem(
            leading: const FaIcon(FontAwesomeIcons.circleInfo),
            index: 6,
            text: AppLocalizations.of(context)!.navBarAbout,
            page: CustomPageRoute(builder: (context) => const AboutPage()),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final CustomPageRoute page;
  final int index;
  final String text;
  final Widget leading;

  const NavItem({
    super.key,
    required this.page,
    required this.index,
    required this.text,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      selected: index == selectedIndex,
      title: Text(text),
      onTap: selectedIndex != index
          ? () {
              selectedIndex = index;
              Navigator.of(context).pushReplacement(page);
            }
          : () {
              Navigator.of(context).pop();
            },
    );
  }
}
