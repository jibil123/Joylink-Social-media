import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joylink/model/bloc/chatBloc/chat_bloc.dart';
import 'package:joylink/view/screens/chatScreen/controller/message_items.dart';
import 'package:joylink/view/screens/chatScreen/widgets/emoji_widget.dart';
import 'package:joylink/viewModel/firebase/chatFetch/fetch_chat.dart';

class ChatScreen extends StatelessWidget {
  final String reciverId;
   ChatScreen({super.key, required this.reciverId});

  final FetchChat fetchChat = FetchChat();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   final ScrollController scrollController = ScrollController();
   final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final chatBloc = BlocProvider.of<ChatBloc>(context);
          bool emojiShowing = state is EmojiToggled && state.isEmojiVisible;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Message Screen'),
              backgroundColor: Colors.blueAccent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildMessageList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    key: formKey,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            chatBloc.add(SendMediaMessage(reciverId: reciverId, file: File(image.path), mediaType: 'image'));
                          }
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
                          if (video != null) {
                            chatBloc.add(SendMediaMessage(reciverId: reciverId, file: File(video.path), mediaType: 'video'));
                          }
                        },
                        icon: const Icon(
                          Icons.video_library,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Enter message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            suffixIcon: IconButton(
                              onPressed: () {
                                chatBloc.add(ToggleEmoji());
                              },
                              icon: const Icon(
                                Icons.emoji_emotions,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          chatBloc.add(SendMessage(
                            reciverId: reciverId,
                            message: messageController.text,
                          ));
                          messageController.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: Color.fromARGB(255, 29, 88, 50),
                        ),
                      ),
                    ],
                  ),
                ),
                EmojiWidget(emojiShowing: emojiShowing, messageController: messageController),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: fetchChat.getMessages(
          reciverId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
           WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });

        return ListView(
          controller: scrollController,
          children: snapshot.data!.docs
              .map((document) => buildMessageItems(context,document))
              .toList(),
        );
      },
    );
  }
}
