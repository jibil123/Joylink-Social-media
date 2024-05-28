import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/view/screens/otherProfileScreen/widgets/profile_stack.dart';
import 'package:joylink/view/screens/otherProfileScreen/widgets/other_user_details.dart';

class OtherProfileScreen extends StatelessWidget {
  const OtherProfileScreen({super.key, required this.userModel,});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:SingleChildScrollView(
        child: Column(
          children: [
            OtherProfileStack(userModel: userModel),
            OtherProfileUserDetails(userModel: userModel)
          ],
        ),
      ) ,
    );
  }
}