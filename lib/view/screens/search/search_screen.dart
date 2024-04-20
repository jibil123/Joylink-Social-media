import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Search Screen'),),
      body: Column(
        children: [
           TextFormField(
              decoration: InputDecoration(
                hintText: 'Search Users',
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
    );
  }
}