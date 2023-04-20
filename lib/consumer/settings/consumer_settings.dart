import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/settings_bloc.dart';
import 'groups/settings_account_group.dart';
import 'groups/settings_general_group.dart';
import 'groups/settings_help_group.dart';
import 'widgets/language_selection.dart';
import 'widgets/privacy_optin.dart';

class ConsumerSettings extends StatelessWidget {
  const ConsumerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                      ),
                    ],
                  ),
                  const SettingsGeneralGroup(),
                  const SettingsAccountGroup(),
                  const SettingsHelpGroup(),
                ],
              ),
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              buildWhen: (previous, current) =>
                  current is SettingsShowLanguageChange ||
                  current is SettingsHideLanguageChange,
              builder: (context, state) {
                if (state is SettingsShowLanguageChange) {
                  return const LanguageSelection();
                }
                return Container();
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              buildWhen: (previous, current) =>
                  current is SettingsShowPrivacyOptIn ||
                  current is SettingsHideLanguageChange,
              builder: (context, state) {
                if (state is SettingsShowPrivacyOptIn) {
                  return const PrivacyOptIn();
                }
                return Container();
              },
            ),
            SizedBox.fromSize(
              size: Size.fromWidth(MediaQuery.of(context).size.width * .02),
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 1) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
