import 'package:flutter/material.dart';
import 'package:joylink/main.dart';
import 'package:joylink/utils/custom_appbar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyAppBar()));
        },
        child: Row(
          children: [
            Image.asset(
              'assets/images/joylink-logo.png',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
      
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50), // Adjust the radius as needed
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
