import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:joylink/view/screens/profileScreen/widgets/cover_image.dart';
import 'package:joylink/view/screens/profileScreen/widgets/follow_text_widget.dart';
import 'package:joylink/view/screens/profileScreen/widgets/profile_photo.dart';
import 'package:joylink/view/screens/profileScreen/widgets/userListScreen/user_list_screen.dart';

class ProfilePhotoScreen extends StatelessWidget {
   ProfilePhotoScreen({super.key});
final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380, // Set the height of the container
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
                    top: 260, // Adjusted top position
                    right: 40, // Adjusted right position
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserListScreen(userIds: following, title: 'Following')));
                          },
                          child: followFunction('Following ',following.length)),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserListScreen(userIds: follow, title: 'Followers')));
                          },
                          child: followFunction('Followers ',follow.length)),
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
