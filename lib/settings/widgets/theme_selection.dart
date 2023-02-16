import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

class AppTheme {
  ThemeMode mode;
  String title;
  IconData icon;

  AppTheme({
    required this.mode,
    required this.title,
    required this.icon,
  });
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    List<AppTheme> appThemes = [
      AppTheme(
        mode: ThemeMode.light,
        title: AppLocalizations.of(context)!.settingsThemeLight,
        icon: FontAwesomeIcons.sun,
      ),
      AppTheme(
        mode: ThemeMode.dark,
        title: AppLocalizations.of(context)!.settingsThemeDark,
        icon: FontAwesomeIcons.moon,
      ),
    ];

    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          appThemes.length,
          (i) {
            bool isSelectedTheme = appThemes[i].mode == themeProvider.theme;
            return GestureDetector(
              onTap: isSelectedTheme
                  ? null
                  : () => themeProvider.setTheme(appThemes[i].mode),
              child: AnimatedContainer(
                margin: const EdgeInsets.all(5),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelectedTheme
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(appThemes[i].icon),
                      const Padding(padding: EdgeInsets.all(3.0)),
                      Text(
                        appThemes[i].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
