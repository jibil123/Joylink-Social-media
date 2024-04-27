part of 'profile_photo_bloc.dart';

@immutable
sealed class ProfilePhotoEvent {}

class SelectProfilePhotoEvent extends ProfilePhotoEvent{}

class SelectPhotoFromCamAndGal extends ProfilePhotoEvent{}
  
class UploadProfilePhoto extends ProfilePhotoEvent{
  final File imageFile;

  UploadProfilePhoto({required this.imageFile});
}
