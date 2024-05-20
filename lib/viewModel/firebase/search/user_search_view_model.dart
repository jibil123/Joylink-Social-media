import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';

class UserSearchViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<UserModel> _allUsers = [];
  final ValueNotifier<List<UserModel>> _usersNotifier =
      ValueNotifier<List<UserModel>>([]);
  bool _isLoading = false;

  ValueNotifier<List<UserModel>> get usersNotifier => _usersNotifier;
  bool get isLoading => _isLoading;

  void fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await _firestore.collection('user details').get();
      _allUsers.clear();
      _allUsers.addAll(
        querySnapshot.docs
            .map((doc) => UserModel.fromFirestore(doc.data()))
            .toList(),
      );
      _usersNotifier.value = List.from(_allUsers);
    } catch (e) {
      return;
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      _usersNotifier.value = List.from(_allUsers);
    } else {
      final filteredUsers = _allUsers
          .where((user) =>
              user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _usersNotifier.value = filteredUsers;
    }
  }
}