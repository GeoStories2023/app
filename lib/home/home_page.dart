import 'package:flutter/material.dart';
import 'package:geostories/navpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavPage(
      body: Center(
        child: Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
