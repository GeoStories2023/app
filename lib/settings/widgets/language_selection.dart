import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import '../locale_provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<StatefulWidget> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getGlobe(context),
        const Padding(padding: EdgeInsets.only(left: 5)),
        SizedBox(
          width: 150,
          child: LanguagePickerDropdown(
            languages: [
              Languages.german,
              Languages.english,
            ],
            initialValue: Language.fromIsoCode(
              localeProvider.locale.languageCode,
            ),
            onValuePicked: (lang) {
              setState(() {
                localeProvider.setLocale(Locale(lang.isoCode));
              });
            },
          ),
        ),
      ],
    );
  }

  // Returns the globe which shows the continent with
  // the corresponding locale.
  Widget _getGlobe(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
    switch (localeProvider.locale.languageCode) {
      case "de":
        return const FaIcon(FontAwesomeIcons.earthEurope);
      case "en":
        return const FaIcon(FontAwesomeIcons.earthAmericas);
    }
    return const FaIcon(FontAwesomeIcons.earthEurope);
  }
}
