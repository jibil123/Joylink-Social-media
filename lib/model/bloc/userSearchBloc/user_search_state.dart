part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchLoading extends UserSearchState {}

class UserSearchLoaded extends UserSearchState {
  final List<UserModel> users;

  UserSearchLoaded(this.users);
}

class UserSearchError extends UserSearchState {
  final String message;

  UserSearchError(this.message);
}