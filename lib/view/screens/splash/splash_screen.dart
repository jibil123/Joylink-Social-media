import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/view/screens/authScreen/mainLoginScreen/login_screen.dart';
import 'package:joylink/view/screens/home/home_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) =>const HomeScreen()));
          } else if (state is UnAuthenticated) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) =>const LoginScreenWrapper()));
          }
        },
        child: const Scaffold(
          body: Center(
            child: Image(
                width: 400,
                height: 400,
                image: AssetImage('assets/images/joylink-logo.png')),
          ),
        ));
  }
}
