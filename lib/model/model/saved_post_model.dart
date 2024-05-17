class SavedPostModel {
  final String postId;
  final String name;
  final String profileImage;
  final String location;
  final String postImage;
  final String date;
  final String description;

  SavedPostModel(
      {required this.postId,
      required this.name,
      required this.profileImage,
      required this.location,
      required this.postImage,
      required this.date,
      required this.description});

  factory SavedPostModel.fromMap(Map<String, dynamic> data, String documentId) {
    return SavedPostModel(
        postId: documentId,
        name: data['name']??'',
        profileImage:data['profileImage'] ??'',
        location:data['location']?? '',
        postImage:data['postImage']?? '',
        date: data['date']??'',
        description:data['description']?? '');
  }
}