import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/splash/splash_bloc.dart';

import '../auth/auth.dart';
import '../consumer/consumer_homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(SplashStart());
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
        if (state is SplashLoginSuccess) {
          return const ConsumerHomePage();
        } else if (state is SplashAutologinFalse) {
          return const AuthPage();
        }
        return _buildSplashScreen(context);
      }),
    );
  }

  Widget _buildSplashScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo_crop.png"),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
