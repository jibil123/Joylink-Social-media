import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/firebase_options.dart';
import 'package:joylink/model/bloc/PostFetchBloc/post_bloc.dart';
import 'package:joylink/model/bloc/chatBloc/chat_bloc.dart';
import 'package:joylink/model/bloc/likeCommentBloc/like_comment_bloc.dart';
import 'package:joylink/model/bloc/themeBloc/theme_bloc.dart';
import 'package:joylink/model/bloc/postBloc/post_bloc.dart';
import 'package:joylink/model/bloc/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:joylink/model/bloc/editDetials/edit_details_bloc.dart';
import 'package:joylink/model/bloc/forgotPassword/forgott_password_bloc.dart';
import 'package:joylink/model/bloc/googleAuthBloc/google_auth_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/model/bloc/profilePhoto/profile_photo_bloc.dart';
import 'package:joylink/model/bloc/savePost/save_post_bloc.dart';
import 'package:joylink/model/bloc/userSearchBloc/user_search_bloc.dart';
import 'package:joylink/view/screens/splash/splash_screen.dart';
import 'package:joylink/viewModel/firebase/fetchData/fetch_post_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    RepositoryProvider(
      create: (context) => Repository(),
      child: const MyApp(),
    ),
  );
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
        BlocProvider(
          create: (context) => ProfilePhotoBloc(),
        ),
        BlocProvider(
          create: (context) => EditDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => PostBloc(),
        ),
        BlocProvider(
          create: (context) => PostFetchBloc(
            repository: RepositoryProvider.of<Repository>(context),
          )..add(FetchPostsEvent()),
        ),
        BlocProvider(
          create: (context) => SavePostBloc()..add(FetchPostSavedEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => SearchQueryBloc(),
        ),
                BlocProvider(
          create: (context) => LikeCommentBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: const SplashScreenWrapper(),
            theme: state.isSwitched?ThemeData.light():ThemeData.dark()
          );
        },
      ),
    );
  }
}
