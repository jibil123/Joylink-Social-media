// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserDataRepository {
//   final currentUser = FirebaseAuth.instance;

//   Future<String?> getUserName() async {
//     try {
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection("users")
//           .where("uid", isEqualTo: currentUser.currentUser?.uid)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         final userData = querySnapshot.docs.first.data();
//         return userData['name'];
//       } else {
//         return null;
//       }
//     } catch (error) {
//       // print('Error fetching user data: $error');
//       return null;
//     }
//   }
// }
