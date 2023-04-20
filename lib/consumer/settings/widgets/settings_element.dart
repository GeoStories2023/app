import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsElement extends StatelessWidget {
  final Function()? onTap;
  final bool submenu;
  final String text;

  const SettingsElement(
    this.text, {
    super.key,
    this.onTap,
  }) : submenu = false;

  const SettingsElement.submenu(
    this.text, {
    super.key,
    this.onTap,
  }) : submenu = true;

  @override
  Widget build(BuildContext context) {
    if (submenu) {
      return _buildSubmenu(context);
    }
    return _buildNormal(context);
  }

  Widget _buildNormal(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSubmenu(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          const FaIcon(FontAwesomeIcons.angleRight),
        ],
      ),
    );
  }
}
