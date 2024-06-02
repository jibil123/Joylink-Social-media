import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joylink/view/screens/profileScreen/widgets/cover_image.dart';
import 'package:joylink/view/screens/profileScreen/widgets/follow_text_widget.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_photo.dart';

class ProfilePhotoScreen extends StatelessWidget {
   ProfilePhotoScreen({super.key});
final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Set the height of the container
      child: Stack(
        children: [
          const CoverImage(),
          StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('user details')
                    .doc(firebaseAuth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final data = snapshot.data!.data() as Map<String, dynamic>?;

                  final follow = (data?['followers'] as List?) ?? [];
                  final following = (data?['following'] as List?) ?? [];

                  return Positioned(
                    top: 265, // Adjusted top position
                    right: 40, // Adjusted right position
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        followFunction('Following ',following.length),
                        const SizedBox(height: 10),
                        followFunction('Followers ',follow.length),
                      ],
                    ),
                  );
                }),
           const ProfilePhoto()
        ],
      ),
    );
  }
}
