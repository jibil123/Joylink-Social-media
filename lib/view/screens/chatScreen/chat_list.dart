import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joylink/view/screens/chatScreen/message_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser)
            .collection('chats')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No chats yet'));
          }

          return FutureBuilder(
            future: FirebaseFirestore.instance.collection('user details').get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userSnapshot.hasError) {
                return const Center(child: Text('Error loading users'));
              }
              if (!userSnapshot.hasData) {
                return const Center(child: Text('No user data found'));
              }

              final userDocs = userSnapshot.data!.docs;
              final userMap = {for (var doc in userDocs) doc.id: doc.data()};

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final chatRoom = snapshot.data!.docs[index];
                  final chatRoomId = chatRoom.id;
                  final receiverId = chatRoomId
                      .split('_')
                      .firstWhere((id) => id != currentUser);
                  final userData = userMap[receiverId] ?? {};
                  final userName = userData['name'] ?? 'No Name';
                  final userProfile = userData['imageUrl'] ?? '';
                  final lastMessage = chatRoom['lastMessage'] ?? '';
                  return ListTile(
                    leading: userProfile.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(userProfile),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                    title: Text(userName),
                    subtitle: Text(lastMessage),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(reciverId: receiverId),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
