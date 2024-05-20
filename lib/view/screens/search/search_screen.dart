import 'package:flutter/material.dart';
import 'package:joylink/view/screens/search/all_users.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Users'),
              Tab(text: 'Recently Searched'),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: TabBarView(
            children: [
              UserSearchScreen(),
              Center(child: Text('tab2')),
            ],
          ),
        ),
      ),
    );
  }
}