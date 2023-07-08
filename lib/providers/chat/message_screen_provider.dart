import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/conf/message_args.dart';
import 'package:commuication/models/message.dart';
import 'package:flutter/material.dart';

class MessagePageProvider extends ChangeNotifier {
  MessageScreenArgs _args = MessageScreenArgs(
    room: ChatRoom(name: "Chat Room", id: "#"),
  );
  final List<Message> _messages = [];

  void changeChatRoom(MessageScreenArgs args) {
    _args = args;
    clearMessages();
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  MessageScreenArgs get args => _args;

  List<Message> get messages => _messages;
}
