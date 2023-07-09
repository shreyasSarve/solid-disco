import 'package:commuication/models/args/message_args.dart';
import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/message.dart';
import 'package:commuication/services/message_service.dart';
import 'package:flutter/material.dart';

class MessagePageProvider extends ChangeNotifier {
  static const int pageSize = 15;
  MessageScreenArgs _args = MessageScreenArgs(
    room: NoChatRoom(),
  );
  final List<Message> _messages = [];
  final MessageService _service = MessageService();
  bool _allChatsFetched = false;

  void changeChatRoom(MessageScreenArgs args) {
    _args = args;
    _clearMessages();
    notifyListeners();
    _allChatsFetched = false;
    addConfig();
  }

  void addMessage(Message message) {
    _messages.insert(0, message);
    _service.saveMessage(message);
    notifyListeners();
  }

  void _clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  Future<void> clearMessages() async {
    _messages.clear();
    await _service.clearBox();
    notifyListeners();
  }

  Future<bool> deleteRoom({String? id}) async {
    if (args is NoChatRoom) return false;
    String roomId = id ?? args.room.id;
    bool result = false;
    if (roomId == args.room.id) {
      result = await _deleteThisRoom();
    } else {
      result = await _deleteOtherRoom(roomId);
    }
    notifyListeners();
    return result;
  }

  Future<bool> _deleteThisRoom() async {
    if (await _service.deleteBox()) {
      await clearMessages();
      changeChatRoom(MessageScreenArgs(room: NoChatRoom()));
      return true;
    }
    return false;
  }

  Future<bool> _deleteOtherRoom(String id) async {
    return await _service.deleteBox(id: id);
  }

  void addConfig() async {
    await _service.init(args.room.id);
    getMessages();
  }

  void getMessages() async {
    if (_allChatsFetched) return;
    final res = await _service.getMessages(pageSize: pageSize);
    _messages.addAll(res.reversed);
    if (res.length != pageSize) _allChatsFetched = true;
    notifyListeners();
  }

  MessageScreenArgs get args => _args;

  List<Message> get messages => _messages;
}
