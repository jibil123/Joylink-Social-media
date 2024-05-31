import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:joylink/model/bloc/chatBloc/chat_bloc.dart';
import 'package:joylink/view/screens/authScreen/utils/customtextformfield.dart';
import 'package:joylink/view/screens/chatScreen/bubble_chat_screen.dart';
import 'package:joylink/viewModel/firebase/chatFetch/fetch_chat.dart';

class ChatScreen extends StatelessWidget {
  final String reciverId;
  ChatScreen({super.key, required this.reciverId});

  final FetchChat fetchChat = FetchChat();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Row(
            key: formKey,
            children: [
              Expanded(
                  child: CustomTextField(
                      hintText: 'Enter message',
                      controller: messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return;
                        } else {
                          return;
                        }
                      })),
              IconButton(
                  onPressed: () {
                    chatBloc.add(SendMessage(
                        reciverId: reciverId, message: messageController.text));
                    messageController.clear();
                  },
                  icon: const Icon(
                    Icons.arrow_upward,
                    size: 40,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream:
            fetchChat.getMessages(reciverId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItems(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

        // Get the timestamp and format it
  Timestamp timestamp = data['timeStamp'];
  DateTime dateTime = timestamp.toDate();
  String formattedTime = DateFormat('h:mm a').format(dateTime); // Using intl package
  
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [ChatBubbleScreen(message: data['message'],time: formattedTime)],
        ),
      ),
    );
  }
}
