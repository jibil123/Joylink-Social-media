import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/home/savedPost/saved_post.dart';
import 'package:joylink/view/screens/otherProfileScreen/widgets/profile_stack.dart';
import 'package:joylink/view/screens/otherProfileScreen/widgets/other_user_details.dart';
import 'package:joylink/view/screens/profileScreen/user_post.dart';

class OtherProfileScreen extends StatelessWidget {
  const OtherProfileScreen({super.key, required this.userModel,});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          OtherProfileStack(userModel: userModel),
          OtherProfileUserDetails(userModel: userModel),
           Padding(
            padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
            child: Container(
              decoration: BoxDecoration(color: AppColors.tealColor,borderRadius: BorderRadius.circular(20)),
              
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserPosts(
                          deleteOrSave: true,
                        ),
                      ));
                  }, child: const Text('Activies',style: TextStyle(color: AppColors.whiteColor))),
                 TextButton(onPressed: (){
                  
                  }, child: const Text('Reel',style: TextStyle(color: AppColors.whiteColor),)),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SavedPostScreen( 
                          isSaved: false,
                        )));
                  }, child: const Text('saved Post',style: TextStyle(color: AppColors.whiteColor),)),
                ],
              ),
            ),
          )
        ],
      ) ,
    );
  }
}