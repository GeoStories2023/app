import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../prefs/theme_provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSwitcher();
}

class _ThemeSwitcher extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    var themeP = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => themeP.setTheme(ThemeMode.dark),
          child: FaIcon(
            FontAwesomeIcons.moon,
            size: 50,
            color: themeP.theme == ThemeMode.dark ? Colors.green : null,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
        GestureDetector(
          onTap: () => themeP.setTheme(ThemeMode.light),
          child: FaIcon(
            FontAwesomeIcons.sun,
            size: 50,
            color: themeP.theme == ThemeMode.light ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}
