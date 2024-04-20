import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/authScreen/mainLoginScreen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: () {
                authBloc.add(LogoutEvent());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) =>const LoginScreenWrapper()),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.blackColor, 
              ))
        ],
      ),
    );
  }
}
