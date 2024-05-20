part of 'like_comment_bloc.dart';

@immutable
sealed class LikeCommentEvent {}

class ToggleLikeEvent  extends LikeCommentEvent{
  final String postId;

  ToggleLikeEvent({required this.postId});
} 

class AddCommentEvent extends LikeCommentEvent{
  final String postId;
  final String commentText;

  AddCommentEvent({required this.postId, required this.commentText});
}

class LoadLikeCommentEvent extends LikeCommentEvent{
  final String postId;

  LoadLikeCommentEvent({required this.postId});
}

