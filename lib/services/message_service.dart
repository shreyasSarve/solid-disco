import 'dart:developer';

import 'package:commuication/models/message.dart';
import 'package:hive/hive.dart';

class MessageService {
  Box? _hiveBox;
  int _lastPage = 0;
  int _messagesSize = 0;

  Future<void> init(String messageId) async {
    _hiveBox = await Hive.openBox(messageId);
    await getConfig();
    _lastPage = _messagesSize;
  }

  // Future<List<Message>> getMessages(int page) async{
  //   final config= _hiveBox.get(RoomConfig.key);

  // }
  Future<void> clearBox() async {
    try {
      await _hiveBox!.clear();
    } catch (e) {}
  }

  Future<void> getConfig() async {
    try {
      final config = await _hiveBox!.getAt(0);
      if (config == null) {
        _messagesSize = 0;
        return;
      }
      _messagesSize = config;
    } catch (e) {
      log("config for room not found", error: e);
      _addConfig();
      _messagesSize = 0;
    }
  }

  Future<void> _addConfig() async {
    try {
      await _hiveBox!.add(0);
    } catch (e) {}
  }

  Future<void> _updateMessageSize() async {
    try {
      _messagesSize++;
      await _hiveBox!.putAt(0, _messagesSize);
    } catch (e) {
      log(
        "Error while adding config for room",
        error: e,
        name: "[ $runtimeType -> addRoomConfig ]",
      );
    }
  }

  Future<List<Message>> getMessages({int pageSize = 10}) async {
    try {
      log("getting messages for ${_hiveBox!.name}");
      final List<Message> messages = [];
      int index = 0;
      for (; index < pageSize && _lastPage > 0; index++) {
        final message = await getAtIndex(_lastPage);
        if (message == null) break;
        _lastPage--;
        messages.add(message);
      }
      return messages.reversed.toList();
    } catch (e) {
      return [];
    }
  }

  Future<Message?> getAtIndex(int index) async {
    try {
      final res = await _hiveBox!.getAt(index);
      return Message.fromJson(res);
    } catch (e) {
      log(
        "Error while retrieving",
        error: e,
        name: "[ MessageService-> getIndex ]",
      );
      return null;
    }
  }

  Future<bool> saveMessage(Message message) async {
    try {
      _hiveBox!.add(message.toJson());
      _updateMessageSize();
      return true;
    } catch (e) {
      log("Error while saving message", error: e);
      return false;
    }
  }

  Future<bool> deleteBox({String? id}) async {
    try {
      await Hive.deleteBoxFromDisk(id ?? _hiveBox!.name);
      return true;
    } catch (e) {
      return false;
    }
  }
}
