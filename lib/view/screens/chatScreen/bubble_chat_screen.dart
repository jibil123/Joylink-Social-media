import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';

class ChatBubbleScreen extends StatelessWidget {
  final String message;
  const ChatBubbleScreen({super.key, required this.message});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.tealColor
      ),
      child: Text(message,style: TextStyle(fontSize: 16),),
    );
  }
}