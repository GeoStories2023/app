import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/settings_element.dart';
import '../widgets/settings_group.dart';

class SettingsHelpGroup extends StatelessWidget {
  const SettingsHelpGroup({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);

    return SettingsGroup(
      icon: const FaIcon(FontAwesomeIcons.questionCircle),
      name: l10n!.settings_help_groupTitle,
      children: [
        SettingsElement(
          l10n.settings_help_tour,
          onTap: () {},
        ),
        SettingsElement(l10n.settings_help_about),
      ],
    );
  }
}
