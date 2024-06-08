import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListScreen extends StatelessWidget {
  final List<dynamic> userIds;
  final String title;

  UserListScreen({required this.userIds, required this.title});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: userIds.length,
        itemBuilder: (context, index) {
          return FutureBuilder<DocumentSnapshot>(
            future: firestore.collection('user details').doc(userIds[index]).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data['imageUrl']),
                ),
                title: Text(data['name']),
                subtitle: Text(data['mail']),
              );
            },
          );
        },
      ),
    );
  }
}
