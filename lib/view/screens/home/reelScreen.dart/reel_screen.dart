import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joylink/model/bloc/cubit/video_player_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/view/screens/home/reelScreen.dart/video_player_widget.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .orderBy('uploadedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final videos = snapshot.data!.docs;
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final videoUrl = videos[index]['url'];
              return BlocProvider(
                create: (_) => VideoPlayerBloc(videoUrl),
                child: const VideoPlayerWidget(),
              );
            },
          );
        },
      ),
    );
  }
}

