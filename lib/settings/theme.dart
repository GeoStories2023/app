import 'package:flutter/material.dart';

const lightBackground = Colors.deepOrangeAccent;
const lightText = Colors.orange;
const lightElement = Colors.orange;

const darkBackground = Color.fromARGB(0xFF, 0x19, 0x19, 0x19);
const darkText = Color.fromARGB(0xFF, 0xEC, 0xDB, 0xBA);
const darkElement = Color.fromARGB(0xFF, 0x2D, 0x42, 0x63);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
