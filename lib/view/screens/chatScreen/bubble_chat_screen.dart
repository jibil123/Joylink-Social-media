import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';

class ChatBubbleScreen extends StatelessWidget {
  final String message;
  final String time;
  final bool isSentByMe;
  final String? mediaUrl;
  final String? mediaType;
  final VoidCallback? onTap;

  const ChatBubbleScreen({
    super.key,
    required this.message,
    required this.time,
    required this.isSentByMe,
    this.mediaUrl,
    this.mediaType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSentByMe ? AppColors.tealColor : Colors.teal[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (mediaType == 'image' && mediaUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  mediaUrl!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ), 
           if (mediaType == 'video' && mediaUrl != null)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 200,                  
                    child: Image.asset('assets/images/cover_photo.jpg',fit: BoxFit.cover,),),
                  const Icon(
                    Icons.play_circle_fill,
                    color: AppColors.whiteColor,
                    size: 50,
                  ),
                ],
              ),
            if (mediaType == null || mediaType == '')
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: isSentByMe ? AppColors.whiteColor : Colors.black87,
                ),
              ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: isSentByMe ? Colors.white60 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
