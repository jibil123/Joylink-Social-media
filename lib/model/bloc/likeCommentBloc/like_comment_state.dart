part of 'like_comment_bloc.dart';

@immutable
sealed class LikeCommentState {}

final class LikeCommentInitial extends LikeCommentState {}

final class LikeCommentLoading extends LikeCommentState{}

class LikeCommentLoaded extends LikeCommentState{
  final bool isLiked;
  final int likeCount;
  final int commentCount;

  LikeCommentLoaded({required this.isLiked, required this.likeCount, required this.commentCount});
}

final class LikeCommentError extends LikeCommentState{
  final String error;

  LikeCommentError({required this.error});
}