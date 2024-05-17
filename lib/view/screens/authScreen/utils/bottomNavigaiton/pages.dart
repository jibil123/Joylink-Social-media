import 'package:flutter/material.dart';
import 'package:joylink/view/screens/home/home_screen.dart';
import 'package:joylink/view/screens/postScreen/post_screen.dart';
import 'package:joylink/view/screens/profileScreen/profile_screen.dart';
import 'package:joylink/view/screens/search/search_screen.dart';
import 'package:joylink/view/screens/settingsScreen/setttings_screen.dart';

List<Widget> tabs = [
    HomeScreen(),
  const SearchScreen(),
   PostScreen(),
   SettingScreen(),
  const ProfileScreen()
];
