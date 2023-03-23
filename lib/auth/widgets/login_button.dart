import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/auth_bloc.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController pwdController;
  const LoginButton(
      {super.key, required this.emailController, required this.pwdController});

  @override
  State<StatefulWidget> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
      child: GestureDetector(
        onTap: () => authBloc.add(
          AuthLoginEmailPressed(
            widget.emailController.text,
            widget.pwdController.text,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  top: 25,
                  bottom: 25,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
