part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class FetchUsersEvent extends UserSearchEvent {}

class SearchUsersEvent extends UserSearchEvent {
  final String query;

  SearchUsersEvent(this.query);
}