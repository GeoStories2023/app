import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String name;
  final Widget icon;
  final Widget child;

  const SettingsGroup({
    super.key,
    required this.icon,
    required this.name,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .75,
        child: Card(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          elevation: 5.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    const Padding(padding: EdgeInsets.only(right: 2)),
                    Text(name),
                  ],
                ),
              ),
              child,
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
