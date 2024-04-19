import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/authScreen/utils/bottomNavigaiton/pages.dart';
import 'package:joylink/view/screens/authScreen/widgets/bottomNavigation/coantainer.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,     
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(child: child, opacity: animation);
            },
            child: tabs[state.currentPageIndex],
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBarContainer(context),
    );
  }
}