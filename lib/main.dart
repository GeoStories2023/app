import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geostories/auth/login_page.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'firebase_options.dart';
import 'prefs/locale_provider.dart';
import 'prefs/prefs.dart';
import 'prefs/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: MultiProvider(
        providers: [
          Provider<PrefsProvider>(create: (context) => PrefsProvider()),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var prefsProvider = Provider.of<PrefsProvider>(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder(
      future: Future.wait([
        prefsProvider.loadPrefs(),
        localeProvider.readLocale(),
        themeProvider.readTheme(),
      ]),
      builder: (context, _) {
        return MaterialApp(
          title: 'GeoStories',
          themeMode: themeProvider.theme,
          darkTheme: ThemeData(brightness: Brightness.dark),
          theme: ThemeData(brightness: Brightness.light),
          locale: localeProvider.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("en"),
            Locale("de"),
          ],
          home: const LoginPage(),
        );
      },
    );
  }
}
