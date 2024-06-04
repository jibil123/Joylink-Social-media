 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joylink/view/screens/chatScreen/bubble_chat_screen.dart';
import 'package:joylink/view/screens/chatScreen/widgets/video_widget.dart';

Widget buildMessageItems(BuildContext context ,DocumentSnapshot document) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var isSentByMe = (data['senderId'] == firebaseAuth.currentUser!.uid);

    Timestamp timestamp = data['timeStamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
 return  Padding(
    padding: const EdgeInsets.all(10),
    child: Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubbleScreen(
        message: data['message'],
        time: formattedTime,
        isSentByMe: isSentByMe,
        mediaUrl: data['mediaUrl'],
        mediaType: data['mediaType'],
        onTap: () {
          if (data['mediaType'] == 'video') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(url: data['mediaUrl']),
              ),
            );
          }
        },
      ),
    ),
  );
  }