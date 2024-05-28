import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/profileScreen/widgets/follow_text_widget.dart';

class OtherProfileStack extends StatelessWidget {
  const OtherProfileStack({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          userModel.coverImage.isNotEmpty
              ? Image.network(
                  userModel.coverImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Image(
                  height: 250,
                  width: double.infinity,
                  image: AssetImage('assets/images/cover_photo.jpg'),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
                  left: 20, 
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                            }, icon: const Icon(Icons.arrow_back_sharp,color: AppColors.blackColor,)),
                ),
              Positioned(
              top: 200,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor, width: 5),
                ),
                child: userModel.imageUrl.isNotEmpty
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(userModel.imageUrl),
                      )
                    : const CircleAvatar(
                        radius: 80,
                        backgroundColor: AppColors.primaryColor,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage('assets/images/pngegg.png'),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
            top: 275 , // Adjusted top position
            right: 10, // Adjusted right position
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              followFunction('Following 541'),
                const SizedBox(height: 10),
              followFunction('Followers 30')        
              ],
            ),
          ),
        ],
      ),
    );
  }
}
