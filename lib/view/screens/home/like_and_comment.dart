import 'package:flutter/material.dart';

class LikeAndCommentButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onComment;
  final bool isLiked;
  final int likeCount;
  final int commentCount;

  const LikeAndCommentButtons({
    super.key, 
    required this.onLike,
    required this.onComment,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: onLike,
              ),
              Text(
                '$likeCount',
                style: TextStyle(
                  color: isLiked ? Colors.red : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.comment, color: Colors.grey),
                onPressed: onComment,
              ),
              Text(
                '$commentCount',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
