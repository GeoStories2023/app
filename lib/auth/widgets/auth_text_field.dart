import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  /// Obscure the input
  final bool obscure;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscure = false,
  });

  @override
  State<StatefulWidget> createState() => _AuthTextField();
}

class _AuthTextField extends State<AuthTextField> {
  bool _textHidden = false;

  @override
  void initState() {
    _textHidden = false;
    setState(() {
      _textHidden = widget.obscure;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _textHidden,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          suffixIcon: _textVisibilityIcon(context),
        ),
      ),
    );
  }

  Widget? _textVisibilityIcon(BuildContext context) {
    return widget.obscure
        ? IconButton(
            color: Colors.grey,
            splashColor: Colors.transparent,
            onPressed: toggleTextVisibility,
            icon: _textHidden
                ? const FaIcon(
                    FontAwesomeIcons.eye,
                  )
                : const FaIcon(FontAwesomeIcons.eyeSlash),
          )
        : null;
  }

  toggleTextVisibility() {
    setState(() {
      _textHidden = !_textHidden;
    });
  }
}
