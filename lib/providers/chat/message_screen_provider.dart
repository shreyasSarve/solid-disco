import 'package:commuication/models/args/message_args.dart';
import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/message.dart';
import 'package:commuication/services/message_service.dart';
import 'package:flutter/material.dart';

class MessagePageProvider extends ChangeNotifier {
  MessageScreenArgs _args = MessageScreenArgs(
    room: NoChatRoom(),
  );
  final List<Message> _messages = [];
  final MessageService _service = MessageService();

  void changeChatRoom(MessageScreenArgs args) {
    _args = args;
    _clearMessages();
    notifyListeners();
    addConfig();
  }

  void addMessage(Message message) {
    _messages.add(message);
    _service.saveMessage(message);
    notifyListeners();
  }

  void _clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  void clearMessages() async {
    _messages.clear();
    await _service.clearBox();
    notifyListeners();
  }

  void deleteRoom() async {}

  void addConfig() async {
    await _service.init(args.room.id);
    getConfig();
  }

  void getConfig() async {
    final res = await _service.getMessages();
    _messages.clear();
    _messages.addAll(res);
    notifyListeners();
  }

  MessageScreenArgs get args => _args;

  List<Message> get messages => _messages;
}
