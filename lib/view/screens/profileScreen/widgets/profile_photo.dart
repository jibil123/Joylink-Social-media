import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/profilePhoto/profile_photo_bloc.dart';
import 'package:joylink/utils/colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final selectPhotoForProfile = BlocProvider.of<ProfilePhotoBloc>(context);
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: auth.currentUser != null
          ? firestore
              .collection('user details')
              .doc(auth.currentUser!.uid)
              .snapshots()
          : null,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;
        final imageUrl = data?['imageUrl'] as String?;

        return BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
          builder: (context, state) {
            if(state is LoadingprofileState){
              return const Padding(
                padding:  EdgeInsets.only(right: 200,top: 250),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Positioned(
              top: 200,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  selectPhotoForProfile.add(SelectPhotoFromCamAndGal());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color:Colors.black54, width: 5),
                  ),
                  child: imageUrl != null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(imageUrl),
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
            );
          },
        );
      },
    );
  }
}
