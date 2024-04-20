import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/profileScreen/profile_edit_screen.dart';
import 'package:joylink/viewModel/firebase/userdata/userdata.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Image(
                  image: AssetImage('assets/images/joylink-logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileInfo(),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileEditScreen())),
                  child: Container(
                    width: 100,
                    color: AppColors.primaryColor,
                    height: 25,
                    child: const Center(
                      child: Text(
                        'Edit',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Bio : Defualt',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Text(
                  'Activities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
