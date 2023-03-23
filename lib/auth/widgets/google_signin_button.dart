import 'package:flutter/material.dart';

import '../auth_service.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<StatefulWidget> createState() => _GoogleSignInButton();
}

class _GoogleSignInButton extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Image.asset(
        "assets/signin/google/ios/2x/btn_google_light_normal_ios.png",
        height: 24,
      ),
      onPressed: () => AuthService().signInWithGoogle(),
      label: const Text("Sign in with Google"),
    );
  }
}
