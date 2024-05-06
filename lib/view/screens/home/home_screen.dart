import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/PostFetchBloc/post_bloc.dart';
import 'package:joylink/model/model/fetch_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/utils/media_quary.dart';
import 'package:joylink/view/screens/home/post_details.dart';
import 'package:joylink/viewModel/date_and_time/date_and_time.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
            final sortedPosts = state.sortedPosts;
            if (users.isEmpty || sortedPosts.isEmpty) {
              return const Center(child: Text('No data found'));
            }
            return ListView.builder(
              itemCount: sortedPosts.length,
              itemBuilder: (context, index) {
                final post = sortedPosts[index];
                final user =
                    users.firstWhere((user) => user.userId == post.userId);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: UsersPostCard(user: user, post: post),
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


