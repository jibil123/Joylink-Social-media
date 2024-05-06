import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joylink/model/model/fetch_model.dart';

class Repository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<User>> getUsers() async {
    final querySnapshot = await _firestore.collection('user details').get();
    return querySnapshot.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<UserPost>> getUserPosts() async {
    final querySnapshot = await _firestore.collection('user post').get();
    return querySnapshot.docs
        .map((doc) => UserPost.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteUserPost(String postId) async {
    await _firestore.collection('user post').doc(postId).delete();
  }
}
