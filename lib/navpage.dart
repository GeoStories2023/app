import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'navbar.dart';

class NavPage extends StatefulWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final Color? navIconColor;

  const NavPage({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.navIconColor,
  });

  @override
  State<StatefulWidget> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavBar(),
      body: Stack(
        children: [
          widget.body,
          Positioned(
            child: IconButton(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: widget.navIconColor,
              ),
              iconSize: 64,
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
