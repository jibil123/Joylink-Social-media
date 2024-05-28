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
    final Timestamp timestamp = Timestamp.now();
    Message newmessage = Message(
        senterId: currentUser,
        receiverId: event.reciverId,
        message: event.message,
        timestamp: timestamp);
        List<String>ids=[currentUser,event.reciverId];
        ids.sort();
        String chatRoomId=ids.join("_");

        await firebaseFirestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newmessage.toMap());
  }
}
