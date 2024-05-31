import 'package:flutter/material.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_picture.dart';
import 'package:joylink/view/screens/profileScreen/userdata/userdata.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           ProfilePhotoScreen(),
           const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ProfileInfo(),
          ),
           SizedBox(
            height: 15,
          ),     
        ],
      ),
    );
  }
}

