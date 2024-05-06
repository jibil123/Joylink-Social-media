class User {
  final String userId;
  final String name;
  final String profilePic;

  User({
    required this.userId,
    required this.name,
    required this.profilePic,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      userId: documentId,
      name: data['name'] ?? '',
      profilePic: data['imageUrl'] ?? '',
    );
  }
}

class UserPost {
  final String postId;
  final String userId;
  final String image;
  final String description;
  final String location;
  final String dateAndTime;
  UserPost({
    required this.dateAndTime,
    required this.location,
    required this.postId,
    required this.userId,
    required this.image,
    required this.description,
  });

  factory UserPost.fromMap(Map<String, dynamic> data, String documentId) {
    return UserPost(
      dateAndTime:data['time']??'',
      location: data['location']??'',
      postId: documentId,
      userId: data['uid'] ?? '',
      image: data['photoUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }
}