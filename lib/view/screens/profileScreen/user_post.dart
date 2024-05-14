import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/PostFetchBloc/post_bloc.dart';
import 'package:joylink/utils/media_quary.dart';
import 'package:joylink/viewModel/date_and_time/date_and_time.dart';

class UserPosts extends StatelessWidget {
  UserPosts({super.key});
  final DateAndTime dateAndTime = DateAndTime();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user Posts'),
      ),
      body: BlocConsumer<PostFetchBloc, PostFetchState>(
        listener: (context, state) {
          if (state is PostError) {
            const Text('error');
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final users = state.users;
            final posts = state.sortedPosts;
            final currentUserId = FirebaseAuth.instance.currentUser
                ?.uid; // Replace with the actual current user ID

            // Filter the posts list to include only posts by the current user
            final currentUserPosts =
                posts.where((post) => post.userId == currentUserId).toList();

            if (users.isEmpty || currentUserPosts.isEmpty) {
              return const Center(child: Text('No data found'));
            }

            return ListView.builder(
              itemCount: currentUserPosts.length,
              itemBuilder: (context, index) {
                final post = currentUserPosts[index];
                final user =
                    users.firstWhere((user) => user.userId == post.userId);
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                          ),
                          title: Text(user.name),
                          subtitle: Text(post.location),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'delete') {
                                context
                                    .read<PostFetchBloc>()
                                    .add(DeletePostEvent(postId: post.postId));
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15)),
                          ),
                          width: double.infinity,
                          height: mediaqueryHeight(0.2, context),
                          child: Image.network(
                            post.image,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              double? progress =
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(
                              "Posted on : ${dateAndTime.formatRelativeTime(post.dateAndTime)}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: SizedBox(
                              height: 40, child: Text(post.description)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
