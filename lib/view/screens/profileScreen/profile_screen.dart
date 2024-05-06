import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/profileScreen/user_post.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_picture.dart';
import 'package:joylink/view/screens/profileScreen/userdata/userdata.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           ProfilePhotoScreen(),
           Padding(
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
