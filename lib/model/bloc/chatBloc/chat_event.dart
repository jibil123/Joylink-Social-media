part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendMessage extends ChatEvent{
  final String reciverId;
  final String message;

  SendMessage({required this.reciverId, required this.message});
}
