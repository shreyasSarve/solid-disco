import 'package:commuication/models/conf/message_args.dart';
import 'package:commuication/models/message.dart';
import 'package:flutter/material.dart';

class MessagePageProvider extends ChangeNotifier {
  MessageScreenArgs _args = MessageScreenArgs(roomName: "Chat Room");
  final List<Message> _messages = [];

  void changeChatRoom(MessageScreenArgs args) {
    _args = args;
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  MessageScreenArgs get args => _args;

  List<Message> get messages => _messages;
}
