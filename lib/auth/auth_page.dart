import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../consumer/consumer_homepage.dart';
import 'bloc/auth_bloc.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoginSuccess) {
          return const ConsumerHomePage();
        } else if (state is AuthAutoLoginInProgress) {
          return Container();
        }
        return const LoginPage();
      },
    );
  }
}
