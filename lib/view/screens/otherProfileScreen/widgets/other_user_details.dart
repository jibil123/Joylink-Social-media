import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/chatScreen/message_screen.dart';
import 'package:joylink/view/screens/profileScreen/user_post.dart';

class OtherProfileUserDetails extends StatelessWidget {
  const OtherProfileUserDetails({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    String bio=userModel.bio;
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${userModel.name}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                
                Text(             
                 userModel.bio.isNotEmpty ?  "  Bio   : $bio" : "Bio     : Null",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=> ChatScreen(reciverId:userModel.id,),
            )),
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.tealColor,
              ),
             
              child: const Center(
                child: Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor 
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
