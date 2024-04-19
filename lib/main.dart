import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/firebase_options.dart';
import 'package:joylink/model/bloc/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:joylink/model/bloc/forgotPassword/forgott_password_bloc.dart';
import 'package:joylink/model/bloc/googleAuthBloc/google_auth_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/view/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => GoogleAuthBloc(),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => ForgottPasswordBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
            )),
        home: const SplashScreenWrapper(),
      ),
    );
  }
}
