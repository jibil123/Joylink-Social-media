import 'package:flutter/material.dart';
import 'package:joylink/view/screens/authScreen/create%20account/create_login.dart';
import 'package:joylink/view/screens/authScreen/introApp/text3.dart';
import 'package:lottie/lottie.dart';

class TextTwoScreen extends StatelessWidget {
  const TextTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>const CreateLoginWarapper())),
                icon: const Icon(Icons.skip_next),
                label: const Text('skip')),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Lottie.asset('assets/animations/animation_2.json',
                      fit: BoxFit.fill)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Get ready to smile, laugh,\n   and connect like never\n      before on Joy Link!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TextThreeScreen())),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
