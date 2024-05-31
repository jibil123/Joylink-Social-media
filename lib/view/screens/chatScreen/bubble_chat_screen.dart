import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';

class ChatBubbleScreen extends StatelessWidget {
  final String message;
  final String time;
  const ChatBubbleScreen(
      {super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.tealColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16,color: AppColors.whiteColor),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
