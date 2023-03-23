import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../business/home/business_home.dart';
import 'bloc/auth_bloc.dart';
import 'email_auth_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: MediaQuery.of(context).size.width * .75,
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
                        MaterialPageRoute(
                            builder: (context) => const EmailAuthPage()),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const BusinessHomePage(),
                        ),
                      ),
                      child: Text(
                        "Business login",
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
