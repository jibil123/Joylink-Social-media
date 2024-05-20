import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:meta/meta.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> _allUsers = [];

  UserSearchBloc() : super(UserSearchInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserSearchState> emit,
  ) async {
    emit(UserSearchLoading());

    try {
      final querySnapshot = await _firestore.collection('user details').get();
      _allUsers = querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data()))
          .toList();
      emit(UserSearchLoaded(_allUsers));
    } catch (e) {
      emit(UserSearchError(e.toString()));
    }
  }

  void _onSearchUsers(
    SearchUsersEvent event,
    Emitter<UserSearchState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(UserSearchLoaded(_allUsers));
    } else {
      final filteredUsers = _allUsers
          .where((user) =>
              user.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(UserSearchLoaded(filteredUsers));
    }
  }
}