part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class PostPhotoAdded extends PostState {
  final Uint8List photo;

  PostPhotoAdded({required this.photo});
}

class PostDescriptionUpdatedState extends PostState {
  final String description;

  PostDescriptionUpdatedState({required this.description});
}

class PostSavedState extends PostState {}

class PostCanceledState extends PostState {}

class PostLoadingState extends PostState {}
