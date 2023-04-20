import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../bloc/settings_bloc.dart';

class PrivacyOptIn extends StatefulWidget {
  const PrivacyOptIn({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyOptIn();
}

class _PrivacyOptIn extends State<PrivacyOptIn> {
  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * .85,
      minHeight: MediaQuery.of(context).size.height * .85,
      panel: Stack(
        children: [
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
}
