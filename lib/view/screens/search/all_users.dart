import 'package:flutter/material.dart';
import 'package:joylink/model/model/search_model.dart';
import 'package:joylink/viewModel/firebase/search/user_search_view_model.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final UserSearchViewModel _viewModel = UserSearchViewModel();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Users',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
            onChanged: (query) {
              _viewModel.searchUsers(query);
            },
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<UserModel>>(
            valueListenable: _viewModel.usersNotifier,
            builder: (context, users, child) {
              if (_viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (users.isEmpty) {
                return const Center(child: Text('No users found'));
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.imageUrl,
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.mail),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
