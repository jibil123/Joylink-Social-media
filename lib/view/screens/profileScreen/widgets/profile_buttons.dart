
import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/home/savedPost/saved_post.dart';
import 'package:joylink/view/screens/profileScreen/userReel/user_reel.dart';
import 'package:joylink/view/screens/profileScreen/user_post.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15,left: 15),
      child: Container(
        decoration: BoxDecoration(color:Colors.teal[300],borderRadius: BorderRadius.circular(20)),
        
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: (){

            }, child: const Text('Activities',style: TextStyle(color: AppColors.whiteColor))),
           TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserReelScreen()));
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
    );
  }
}