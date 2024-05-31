import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senterId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senterId,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senterId,
      'reciverId': receiverId,
      'message': message,
      'timeStamp': timestamp
    };
  }
}
