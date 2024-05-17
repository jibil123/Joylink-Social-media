import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/savePost/save_post_bloc.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/home/post_details.dart';

class SavedPostScreen extends StatelessWidget {
  const SavedPostScreen({super.key, required this.isSaved});
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
      ),
      body: BlocProvider(
        create: (context) => SavePostBloc()..add(FetchPostSavedEvent()),
        child: BlocConsumer<SavePostBloc, SavePostState>(
          listener: (context, state) {
            if (state is UnSaveSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Unsave successful'),
                backgroundColor: AppColors.primaryColor,
              ));
              context.read<SavePostBloc>().add(FetchPostSavedEvent());  // Fetch updated posts
            }
          },
          builder: (context, state) {
            if (state is loadingSavedState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedSavedPosts) {
              final savedPosts = state.savedPosts;
              if (savedPosts.isEmpty) {
                return const Center(child: Text('No data found'));
              }
              return ListView.builder(
                itemCount: savedPosts.length,
                itemBuilder: (context, index) {
                  final post = savedPosts[index];
                  return UsersPostCard(
                    savedPostModel: post,
                    isSaveOrNot: isSaved,
                  );
                },
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
