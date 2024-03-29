import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'auth/auth.dart';
import 'consumer/profile/profile_bloc.dart';
import 'consumer/settings/bloc/settings_bloc.dart';
import 'consumer/tour/bloc/preview_bloc.dart';
import 'consumer/tour/repositories/map_rest_repo.dart';
import 'firebase_options.dart';
import 'prefs/locale_provider.dart';
import 'prefs/prefs.dart';
import 'prefs/theme_provider.dart';
import 'splash/splash_bloc.dart';

void main() async {
  final MapRestRepo mapRestRepo = MapRestRepo();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PreviewBloc(mapRestRepo)),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(
            SplashInitial(),
            BlocProvider.of<AuthBloc>(context),
          ),
        ),
        BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
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
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("en"),
            Locale("de"),
          ],
          home: const AuthPage(),
        );
      },
    );
  }
}
