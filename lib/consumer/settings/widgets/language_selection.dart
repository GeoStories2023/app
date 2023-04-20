import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../prefs/locale_provider.dart';
import '../bloc/settings_bloc.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LanguageSelection();
}

class _LanguageSelection extends State<LanguageSelection> {
  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * .85,
      minHeight: MediaQuery.of(context).size.height * .85,
      panel: Stack(
        children: [
          _languageList(context),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => settingsBloc.add(SettingsLanguageChanged()),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Finished"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageList(BuildContext context) {
    var langPref = Provider.of<LocaleProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15),
      child: ListView(
        children: [
          InkWell(
            child: const Text("German"),
            onTap: () => langPref.setLocale(const Locale("de")),
          ),
          InkWell(
            child: const Text("English"),
            onTap: () => langPref.setLocale(const Locale("en")),
          ),
        ],
      ),
    );
  }
}
