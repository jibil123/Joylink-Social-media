import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Edit your name',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 188, 176, 176),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Edit your name',         
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 188, 176, 176),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
