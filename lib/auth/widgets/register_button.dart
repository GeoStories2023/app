import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/auth_bloc.dart';

class RegisterButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController pwdController;
  final TextEditingController pwdRepeatController;
  const RegisterButton({
    super.key,
    required this.emailController,
    required this.pwdController,
    required this.pwdRepeatController,
  });

  @override
  State<StatefulWidget> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
      child: GestureDetector(
        onTap: () => authBloc.add(
          AuthRegisterEmailPressed(
            widget.emailController.text,
            widget.pwdController.text,
            widget.pwdRepeatController.text,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n!.auth_email_register,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  top: 25,
                  bottom: 25,
                ),
              ),
              const FaIcon(
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
