import 'package:flutter/material.dart';
import 'package:joylink/view/screens/profileScreen/widgets/follow_text_widget.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_photo.dart';

class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Set the height of the container
      child: Stack(
        children: [
          const Image(
            height: 250,
            width: double.infinity,
            image: AssetImage('assets/images/cover_photo.jpg'),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 275 , // Adjusted top position
            right: 10, // Adjusted right position
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              followFunction('Following 541'),
                const SizedBox(height: 10),
              followFunction('Followers 30'),
              ],
            ),
          ),
           const ProfilePhoto()
        ],
      ),
    );
  }
}
