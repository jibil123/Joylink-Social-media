import 'package:flutter/material.dart';
import 'package:joylink/view/screens/authScreen/create%20account/create_login.dart';
import 'package:lottie/lottie.dart';

class TextThreeScreen extends StatelessWidget {
  const TextThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
        body: Padding(
      padding: const EdgeInsets.only(left: 20,right: 20), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset('assets/animations/animation_3.json',
                  fit: BoxFit.fill)),
                  const SizedBox(height: 10,),
          const Center(
            child: Text(
              '    Join us in spreading\n   happiness connecting\nwith friends, and sharing\n        joyful moments!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>const CreateLoginWarapper())),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                "Start",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    ));
  }
}