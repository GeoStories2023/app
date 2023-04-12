import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/auth_text_field.dart';
import 'widgets/login_button.dart';

class EmailRegisterPage extends StatelessWidget {
  const EmailRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();
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
                  LoginButton(
                    emailController: emailController,
                    pwdController: pwdController,
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
