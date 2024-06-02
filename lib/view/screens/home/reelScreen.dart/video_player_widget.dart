import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/cubit/video_player_cubit.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerInitialized) {
              return Chewie(controller: state.chewieController);
            } else if (state is VideoPlayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoPlayerError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        // Add any additional UI elements or overlays here
      ],
    );
  }
}

