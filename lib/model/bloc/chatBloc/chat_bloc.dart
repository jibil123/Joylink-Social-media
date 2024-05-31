import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joylink/model/model/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>(sendMessage);
  }
  sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final FirebaseAuth firebaseAth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final String currentUser = firebaseAth.currentUser!.uid;
    final String receiverId = event.reciverId;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senterId: currentUser,
        receiverId: event.reciverId,
        message: event.message,
        timestamp: timestamp);
    List<String> ids = [currentUser, event.reciverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    await firebaseFirestore
        .collection('users')
        .doc(currentUser)
        .collection('chats')
        .doc(chatRoomId)
        .set({
      'receiverId': receiverId,
      'lastMessage': event.message,
      'timestamp': Timestamp.now(),
    });


    // Also add the message to the receiver's chat messages
    await firebaseFirestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(chatRoomId)
        .set({
      'receiverId': currentUser,
      'lastMessage': event.message,
      'timestamp': Timestamp.now(),
    });
  }
}
