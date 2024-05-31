import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/likeCommentBloc/like_comment_bloc.dart';
import 'package:joylink/model/model/saved_post_model.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/utils/media_quary.dart';
import 'package:joylink/view/screens/home/image_preview.dart';
import 'package:joylink/view/screens/home/like_and_comment.dart';
import 'package:joylink/view/screens/home/popup_menu_button.dart';
import 'package:joylink/view/screens/home/widgets/comment_dialog.dart';
import 'package:joylink/view/screens/otherProfileScreen/other_profile_screen.dart';
import 'package:joylink/viewModel/date_and_time/date_and_time.dart';

class UsersPostCard extends StatelessWidget {
  UsersPostCard(
      {super.key, required this.savedPostModel, required this.isSaveOrNot});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DateAndTime dateAndTime = DateAndTime();
  final SavedPostModel savedPostModel;
  final bool isSaveOrNot;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeCommentBloc()
        ..add(LoadLikeCommentEvent(postId: savedPostModel.postId)),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                UserModel userModel = UserModel(
                  followers:savedPostModel.followers ,
                  following: savedPostModel.following,
                  coverImage: savedPostModel.coverImage,
                  id: savedPostModel.uid,
                  name: savedPostModel.name,
                  mail: savedPostModel.mail,
                  imageUrl: savedPostModel.profileImage,
                  bio: savedPostModel.bio,
                );
                final String id = auth.currentUser!.uid;
                if (id == savedPostModel.uid) {
                  return;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        OtherProfileScreen(userModel: userModel),
                  ));
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              leading: savedPostModel.profileImage.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(savedPostModel.profileImage),
                    )
                  : ClipOval(
                      child: Container(
                        width: 40,
                        height: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/joylink-logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              title: Text(
                savedPostModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(savedPostModel.location),
              trailing: PopupHomeMenu(
                savedPostModel: savedPostModel,
                isSaveOrNot: isSaveOrNot,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImagePreviewScreen(
                        description: savedPostModel.description,
                        imageUrl: savedPostModel.postImage,
                      ))),
              child: Container(
                width: double.infinity,
                height: mediaqueryHeight(0.2, context),
                decoration: const BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
                child: Image.network(
                  savedPostModel.postImage,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    double? progress =
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null;
                    return Center(
                      child: CircularProgressIndicator(
                        value: progress,
                      ),
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<LikeCommentBloc, LikeCommentState>(
              builder: (context, state) {
                if (state is LikeCommentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LikeCommentLoaded) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user post')
                        .doc(savedPostModel.postId)
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      int commentCount = snapshot.data?.docs.length ?? 0;
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('user post')
                            .doc(savedPostModel.postId)
                            .collection('likes')
                            .snapshots(),
                        builder: (context, likeSnapshot) {
                          if (likeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          int likeCount = likeSnapshot.data?.docs.length ?? 0;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LikeAndCommentButtons(
                                onLike: () {
                                  BlocProvider.of<LikeCommentBloc>(context).add(
                                      ToggleLikeEvent(
                                          postId: savedPostModel.postId));
                                },
                                onComment: () {
                                  showCommentBottomSheet(
                                    context,
                                    savedPostModel.postId,
                                  );
                                },
                                isLiked: state.isLiked,
                                likeCount: likeCount,
                                commentCount: commentCount,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "Posted on: ${dateAndTime.formatRelativeTime(savedPostModel.date)}",
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else if (state is LikeCommentError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                savedPostModel.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
