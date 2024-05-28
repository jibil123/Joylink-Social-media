import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
         body: ElevatedButton(onPressed:(){
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen()));
      }, child: Text('toChatScreen')),
    );
  }
}