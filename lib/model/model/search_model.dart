class UserModel {
  final String id;
  final String name;
  final String mail;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.imageUrl,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'] ?? '',
      mail: data['mail'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}