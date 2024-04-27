part of 'profile_photo_bloc.dart';

@immutable
sealed class ProfilePhotoState {}

final class ProfilePhotoInitial extends ProfilePhotoState {
  
}
class LoadingprofileState extends ProfilePhotoState{}

class ProfilePictureSelectedState extends ProfilePhotoState {
  final String? imageFile;

  ProfilePictureSelectedState({required this.imageFile});
}

class ShowdiologProfileState extends ProfilePhotoState{}
