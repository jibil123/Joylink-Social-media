import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/likeCommentBloc/like_comment_bloc.dart';

class CommentBottomSheet extends StatelessWidget {
  final String postId;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();

  CommentBottomSheet({super.key, 
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final likeCommandBloc = BlocProvider.of<LikeCommentBloc>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseFirestore
                  .collection('user post')
                  .doc(postId)
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No comments yet'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var commentData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(commentData['userProfileImage']),
                      ),
                      title: Text(commentData['userName']),
                      subtitle: Text(commentData['text']),
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (_commentController.text.trim().isEmpty) {
                    return;
                  }
                
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    DocumentSnapshot userDetailsSnapshot =
                        await _firebaseFirestore
                            .collection('user details')
                            .doc(currentUser.uid)
                            .get();
                    if (userDetailsSnapshot.exists) {
                      String userName = userDetailsSnapshot['name'];
                      String userProfileImage =
                          userDetailsSnapshot['imageUrl'];
                
                      _firebaseFirestore
                          .collection('user post')
                          .doc(postId)
                          .collection('comments')
                          .add({
                        'text': _commentController.text.trim(),
                        'user': FirebaseAuth.instance.currentUser!.uid,
                        'userName': userName,
                        'userProfileImage': userProfileImage,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _commentController.clear();
                      likeCommandBloc
                          .add(LoadLikeCommentEvent(postId: postId));
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
