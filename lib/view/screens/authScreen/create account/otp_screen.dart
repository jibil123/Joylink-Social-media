import 'package:flutter/material.dart';
import 'package:joylink/view/screens/authScreen/create%20account/user_name.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20), 
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter the confirmation code',style: TextStyle(fontSize: 20),),
            const SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 188, 176, 176)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Confirm password',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>const UserName())),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green[500],
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
      ),
    );
  }
}