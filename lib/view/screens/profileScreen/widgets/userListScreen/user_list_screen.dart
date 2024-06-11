import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/followBloc/follow_bloc.dart';
import 'package:joylink/viewModel/firebase/follow_unfollow/follow_unfollow.dart';

class UserListScreen extends StatelessWidget {
  final List<dynamic> initialUserIds;
  final String title;

  UserListScreen(
      {super.key, required this.initialUserIds, required this.title});

  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title=='Following'?
        Text(title):const Text('Followers'),
      ),
      body: BlocProvider(
        create: (context) => FollowBloc(UserService()),
        child: BlocBuilder<FollowBloc, FollowState>(
          builder: (context, state) {
            List<dynamic> userIds = initialUserIds;
            if (state is FollowUpdated) {
              userIds = state.updatedUserIds;
            }

            if (userIds.isEmpty) {
              return const Center(
                child: Text(
                  'No users to display.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('user details')
                  .where(FieldPath.documentId, whereIn: userIds)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No users found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                final userDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: userDocs.length,
                  itemBuilder: (context, index) {
                    final data = userDocs[index].data() as Map<String, dynamic>;
                    final otherUserId = data['uid'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['imageUrl']),
                      ),
                      title: Text(data['name']),
                      subtitle: Text(data['mail']),
                      trailing: title=="Following"?
                       TextButton(
                        onPressed: () {
                          context.read<FollowBloc>().add(UnfollowUserEvent(
                              firebaseAuth.currentUser!.uid, otherUserId));
                        },
                        child: const Text(
                          'UnFollow',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ):
                      TextButton(
                        onPressed: () {
                          context.read<FollowBloc>().add(UnfollowUserEvent(
                             otherUserId , firebaseAuth.currentUser!.uid));
                        },
                        child: const Text(
                          'UnFollow',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
