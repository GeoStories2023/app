import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:geostories_app/auth/email_auth_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../business/home/business_home.dart';
import '../widgets/page_transitions.dart';
import 'bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      "https://assets2.lottiefiles.com/private_files/lf30_polnr9xa.json",
                      width: width * .5,
                      fit: BoxFit.fill,
                    ),
                    Lottie.network(
                      "https://assets1.lottiefiles.com/packages/lf20_szrbrL.json",
                      width: width * .5,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () =>
                          authBloc.add(const AuthLoginGooglePressed()),
                    ),
                    SignInButton(
                      Buttons.Apple,
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Email,
                      onPressed: () => Navigator.of(context).push(
                        slideLeftTransition(const EmailAuthPage()),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const BusinessHomePage(),
                        ),
                      ),
                      child: Text(
                        l10n!.auth_business_login,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
