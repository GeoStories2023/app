import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geostories/settings/widgets/language_selection.dart';
import 'package:geostories/settings/widgets/settings_group.dart';
import 'package:geostories/settings/widgets/unit_selector.dart';

import '../navpage.dart';
import 'widgets/theme_selection.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavPage(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SettingsGroup(
              icon: FaIcon(FontAwesomeIcons.sun),
              name: "Theme",
              child: ThemeSwitcher(),
            ),
            SettingsGroup(
              icon: const FaIcon(FontAwesomeIcons.language),
              name: "Language",
              child: Column(children: const [
                LanguageSelector(),
                UnitSelector(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
