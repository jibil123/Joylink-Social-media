import 'package:flutter/material.dart';
import 'package:joylink/model/model/fetch_model.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/utils/media_quary.dart';
import 'package:joylink/viewModel/date_and_time/date_and_time.dart';

class UsersPostCard extends StatelessWidget {
  UsersPostCard({
    super.key,
    required this.user,
    required this.post,
  });
  final User user;
  final UserPost post;
  final DateAndTime dateAndTime = DateAndTime();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            leading:user.profilePic.isNotEmpty?
             CircleAvatar( 
              backgroundImage: NetworkImage(user.profilePic),
            ):const CircleAvatar(backgroundColor: AppColors.primaryColor,),
            title: Text(
              user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(post.location),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'save',
                  child: Text('Save'),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: mediaqueryHeight(0.2, context),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Image.network(
              post.image,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                double? progress = loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null;
                return Center(
                  child: CircularProgressIndicator(
                    value: progress,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Posted on: ${dateAndTime.formatRelativeTime(post.dateAndTime)}",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              post.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
