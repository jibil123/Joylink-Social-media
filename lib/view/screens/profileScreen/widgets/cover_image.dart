import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/profilePhoto/profile_photo_bloc.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final coverbloc = BlocProvider.of<ProfilePhotoBloc>(context);
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
          final imageUrl = data?['coverImage'] as String?;

          return BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
            builder: (context, state) {
              if (state is LoadingCoverState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GestureDetector(
                onTap: () {
                  coverbloc.add(SelectCoverPhotoEvent());
                },
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
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
              );
            },
          );
        });
  }
}
