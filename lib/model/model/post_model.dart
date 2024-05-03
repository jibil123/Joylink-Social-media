import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class PostModel {
  String? location;
  Uint8List? photo;
  String? description;
  String? id;
  String? name;
  String? profileImage;
  String? postImage;
  
  PostModel(
      {this.photo,
      this.description,
      this.id,
      this.location,
      this.profileImage,
      this.name,
      this.postImage});
}
