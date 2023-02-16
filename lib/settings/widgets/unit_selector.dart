import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../locale_provider.dart';

/// Allows user to select which unit the program
/// should use.
/// - metric
/// - imperial.
class UnitSelector extends StatefulWidget {
  const UnitSelector({super.key});

  @override
  State<StatefulWidget> createState() => _UnitSelector();
}

class _UnitSelector extends State<UnitSelector> {
  late Units selected;
  List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      value: Units.metric,
      child: Text("Metric"),
    ),
    const DropdownMenuItem(
      value: Units.imperial,
      child: Text("Imperial"),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(FontAwesomeIcons.ruler),
        const Padding(padding: EdgeInsets.only(left: 5)),
        DropdownButton(
          items: items,
          value: localeProvider.unit,
          onChanged: (val) => setState(() {
            localeProvider.setUnit(val);
            selected = val;
          }),
        ),
      ],
    );
  }
}
