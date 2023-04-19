import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String name;
  final Widget icon;
  final List<Widget> children;

  const SettingsGroup({
    super.key,
    required this.icon,
    required this.name,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: [
                      icon,
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black),
                for (Widget c in children)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: c,
                  ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
