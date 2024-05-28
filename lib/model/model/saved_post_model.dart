class SavedPostModel {
  final String uid;
  final String postId;
  final String name;
  final String profileImage;
  final String location;
  final String postImage;
  final String date;
  final String description;
  final String bio;
  final String coverImage;
  final String mail;

  SavedPostModel(
      {required this.mail,
        required this.uid,
      required this.bio,
      required this.coverImage,  
      required this.postId,
      required this.name,
      required this.profileImage,
      required this.location,
      required this.postImage,
      required this.date,
      required this.description});

  factory SavedPostModel.fromMap(Map<String, dynamic> data, String documentId) {
    return SavedPostModel(
        postId: documentId,
        mail: data['mail']??'',
        uid: data['uid']??'',
        name: data['name']??'',
        profileImage:data['profileImage'] ??'',
        location:data['location']?? '',
        postImage:data['postImage']?? '',
        date: data['date']??'',
        description:data['description']?? '',
        bio: data['bio']??'',
        coverImage: data['coverImage']??'');
  }
}
