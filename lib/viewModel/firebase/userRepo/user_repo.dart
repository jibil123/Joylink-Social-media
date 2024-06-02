import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joylink/model/model/fetch_user_model.dart';

class UserRepo {
Future<UserDetails?> getUserData() async {
  try {

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return null;
    }
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
       .collection('user details')
       .doc(uid)
       .get();
    UserDetails userData = UserDetails.fromDocumentSnapshot(docSnapshot,uid);
    return userData;
  } catch (e) {
    print("Error fetching user data: $e");
    return null;
  }
}

}
