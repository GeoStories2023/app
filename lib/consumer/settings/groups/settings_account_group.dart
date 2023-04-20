import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../auth/auth.dart';
import '../../../prefs/prefs.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/settings_element.dart';
import '../widgets/settings_group.dart';

class SettingsAccountGroup extends StatelessWidget {
  const SettingsAccountGroup({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    var prefs = Provider.of<PrefsProvider>(context).prefs;

    return SettingsGroup(
      icon: const FaIcon(FontAwesomeIcons.userCog),
      name: l10n!.settings_account_groupTitle,
      children: [
        SettingsElement.submenu(
          l10n.settings_account_privacy,
          onTap: () => settingsBloc.add(
            SettingsPrivacyOptInSelected(),
          ),
        ),
        SettingsElement(
          "Restore Stuff",
          onTap: () {
            prefs.remove("firstTime");
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Restored"),
                );
              },
            );
          },
        ),
        SettingsElement(
          l10n.settings_account_deleteAccount,
          onTap: () {},
        ),
        SettingsElement(
          l10n.settings_account_logout,
          onTap: () {
            authBloc.add(AuthLogoutPressed());
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ));
          },
        ),
      ],
    );
  }
}
