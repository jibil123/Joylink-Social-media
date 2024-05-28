class UserModel {
  final String id;
  final String name;
  final String mail;
  final String imageUrl;
  final String coverImage;
  final String bio;
  UserModel({
    required this.coverImage,
    required this.id,
    required this.name,
    required this.mail,
    required this.imageUrl,
    required this.bio,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'] ?? '',
      mail: data['mail'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      coverImage: data['coverImage']??'',
      bio: data['bio']??'',
    );
  }
}