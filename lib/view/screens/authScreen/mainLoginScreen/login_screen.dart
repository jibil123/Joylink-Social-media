import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/view/screens/authScreen/introApp/text1.dart';
import 'package:joylink/view/screens/home/home_screen.dart';
import 'package:joylink/view/screens/authScreen/utils/custom_button.dart';
import 'package:joylink/view/screens/authScreen/utils/customtextformfield.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedErrors) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Enter correct email and password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red,
      ));
        }
      },
      builder: (context, state) {
        // if (state is AuthLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false);
          });
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Center(
                        child: Image(
                            width: 200,
                            height: 200,
                            image:
                                AssetImage('assets/images/joylink-logo.png'))),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomTextField(
                        hintText: 'Enter email address',
                        obscureText: false,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    CustomTextField(
                        hintText: 'Enter your password',
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter valid password';
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    const Text(
                      'Forgott password ?',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        buttonText: 'Log in',
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            authbloc.add(LoginEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));
                          }
                        }),
                    const SizedBox(height: 10),
                    CustomButton(
                        buttonText: 'Create a new account',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TextOneScreen()));
                        }),
                    const SizedBox(height: 10),
                    const Column(
                      children: [
                        Center(child: Text('  Or sing in\nwith Google')),
                        Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('assets/images/google.png'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
