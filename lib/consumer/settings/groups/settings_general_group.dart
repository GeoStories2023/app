import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/settings_bloc.dart';
import '../widgets/settings_element.dart';
import '../widgets/settings_group.dart';
import '../widgets/theme_switcher.dart';

class SettingsGeneralGroup extends StatelessWidget {
  const SettingsGeneralGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    var l10n = AppLocalizations.of(context);
    return SettingsGroup(
      icon: const Hero(
        tag: "settingsBtn",
        child: FaIcon(FontAwesomeIcons.cog),
      ),
      name: l10n!.settings_settings_groupTitle,
      children: [
        const ThemeSwitcher(),
        SettingsElement.submenu(
          l10n.settings_settings_language,
          onTap: () => settingsBloc.add(
            SettingsLanguageChangeSelected(),
          ),
        ),
        SettingsElement.submenu(l10n.settings_settings_permissions)
      ],
    );
  }
}
