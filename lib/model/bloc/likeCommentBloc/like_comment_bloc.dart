import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'like_comment_event.dart';
part 'like_comment_state.dart';

class LikeCommentBloc extends Bloc<LikeCommentEvent, LikeCommentState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LikeCommentBloc() : super(LikeCommentInitial()) {
    on<ToggleLikeEvent>(_onToggleLike);
    on<AddCommentEvent>(_onAddComment);
    on<LoadLikeCommentEvent>(_onLoadLikeComment);
  }

  Future<void> _onLoadLikeComment(LoadLikeCommentEvent event, Emitter<LikeCommentState> emit) async {
    // emit(LikeCommentLoading());
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return;
      }
      DocumentReference postRef = _firebaseFirestore.collection('user post').doc(event.postId);
      DocumentSnapshot postSnapshot = await postRef.get();
      if (!postSnapshot.exists) {
        emit(LikeCommentError(error: 'Post not found'));
        return;
      }

      QuerySnapshot likeSnapshot = await postRef.collection('likes').get();
      QuerySnapshot commentSnapshot = await postRef.collection('comments').get();

      bool isLiked = likeSnapshot.docs.any((doc) => doc.id == user.uid);
      int likeCount = likeSnapshot.docs.length;
      int commentCount = commentSnapshot.docs.length;

      emit(LikeCommentLoaded(isLiked: isLiked, likeCount: likeCount, commentCount: commentCount));
    } catch (e) {
      emit(LikeCommentError(error: e.toString()));
    }
  }

  Future<void> _onToggleLike(ToggleLikeEvent event, Emitter<LikeCommentState> emit) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return;
      }
      DocumentReference likeRef = _firebaseFirestore
          .collection('user post')
          .doc(event.postId)
          .collection('likes')
          .doc(user.uid);
      DocumentSnapshot likeSnapshot = await likeRef.get();
      if (likeSnapshot.exists) {
        await likeRef.delete();
      } else {
        await likeRef.set(<String, dynamic>{});
      }
      // Reload the likes and comments after toggling the like
      add(LoadLikeCommentEvent(postId: event.postId));
    } catch (e) {
      emit(LikeCommentError(error: e.toString()));
    }
  }

  Future<void> _onAddComment(AddCommentEvent event, Emitter<LikeCommentState> emit) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return;
      }
      DocumentReference commentRef = _firebaseFirestore
          .collection('user post')
          .doc(event.postId)
          .collection('comments')
          .doc();
      await commentRef.set(<String, dynamic>{
        'text': event.commentText,
        'user': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Reload the likes and comments after adding a comment
      add(LoadLikeCommentEvent(postId: event.postId));
    } catch (e) {
      emit(LikeCommentError(error: e.toString()));
    }
  }
}
