import 'package:flutter/material.dart';
import 'package:joylink/view/screens/chatScreen/chat_list.dart';
import 'package:joylink/view/screens/home/home_screen.dart';
import 'package:joylink/view/screens/home/reelScreen.dart/reel_screen.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});
final bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: 'image',
              ),
              Tab(
                text: 'reel',
              ),
              Tab(
                text: 'poll',
              ),
            ]),
             title: const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
      
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChatListScreen()));
                  },
                  icon: const Icon(Icons.chat)),
            )
          ],
          ),
          body: const TabBarView(children: [
            HomeScreen(),
            ReelScreen(),
            Center(child: Text('poll')),
          ]),
        ));
  }
}