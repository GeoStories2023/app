import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';
import 'settings/locale_provider.dart';
import 'settings/theme.dart';
import 'settings/theme_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const EntryPoint(),
    ),
  );
  // TODO start IPS process here.
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var localeProvider = Provider.of<LocaleProvider>(context);

    return FutureBuilder(
      future: Future.wait([
        themeProvider.readTheme(),
        localeProvider.readLocale(),
        localeProvider.readUnit(),
      ]),
      builder: (context, _) {
        return MaterialApp(
          title: "GeoStories",
          home: const HomePage(),
          themeMode: themeProvider.theme,
          theme: lightTheme,
          darkTheme: darkTheme,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("de"),
            Locale("en"),
          ],
        );
      },
    );
  }
}
