import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_picture.dart';
import 'package:joylink/viewModel/firebase/userdata/userdata.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfilePhotoScreen(),
          const Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: ProfileInfo(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
              child: Text(
                'Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
