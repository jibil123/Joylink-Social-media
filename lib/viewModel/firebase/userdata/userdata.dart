import 'package:flutter/material.dart';
import 'package:joylink/viewModel/firebase/userdata/user_data_repo.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final UserDataRepository _userRepository = UserDataRepository();
  late Future<String?> _userNameFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = _userRepository.getUserName();
  }

  @override
  void dispose() {
    // Cancel the Future operation when the widget is disposed
    _userNameFuture = Future.value(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userNameFuture,
      builder: (context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Text('Error fetching user data');
        }

        return Text(
          'User name : ${snapshot.data}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
