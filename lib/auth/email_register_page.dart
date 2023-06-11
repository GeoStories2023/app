import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geostories/auth/auth.dart';
import 'package:geostories/auth/widgets/register_button.dart';

import 'widgets/auth_text_field.dart';

class EmailRegisterPage extends StatelessWidget {
  const EmailRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();
    final TextEditingController pwdRepeatedController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FaIcon(
                      FontAwesomeIcons.paperPlane,
                      size: MediaQuery.of(context).size.width * .25,
                    ),
                  ),
                  AuthTextField(
                    controller: emailController,
                    hintText: l10n!.auth_email_email,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  AuthTextField(
                    controller: pwdController,
                    hintText: l10n.auth_email_password,
                    obscure: true,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  AuthTextField(
                    controller: pwdRepeatedController,
                    hintText: l10n.auth_email_password_repeat,
                    obscure: true,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    if (state is AuthEmailRegisterFailure) {
                      String reason = state.error == RegisterError.passwordMatch
                          ? "passwords do not match"
                          : "account already exists";
                      return Text(
                        reason,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Container();
                  }),
                  RegisterButton(
                    emailController: emailController,
                    pwdController: pwdController,
                    pwdRepeatController: pwdRepeatedController,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const FaIcon(FontAwesomeIcons.angleLeft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
