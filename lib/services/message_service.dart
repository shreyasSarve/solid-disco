import 'dart:developer';

import 'package:commuication/models/conf/room_config.dart';
import 'package:commuication/models/message.dart';
import 'package:hive/hive.dart';

class MessageService {
  late Box _hiveBox;
  int _lastPage = 0;
  bool isBoxInitialized = false;
  Future<void> init(String messageId) async {
    _hiveBox = await Hive.openBox(messageId);
    _lastPage = 0;
  }

  // Future<List<Message>> getMessages(int page) async{
  //   final config= _hiveBox.get(RoomConfig.key);

  // }
  Future<void> clearBox() async {
    await _hiveBox.clear();
  }

  Future<RoomConfig?> getConfig() async {
    try {
      final config = await _hiveBox.get(RoomConfig.key);
      if (config != null) {
        return RoomConfig.fromJson(config);
      }
      return null;
    } catch (e) {
      log("config for room not found", error: e);
      return null;
    }
  }

  Future<bool> addRoomConfig(RoomConfig config) async {
    try {
      await _hiveBox.add(config.toJson());
      return true;
    } catch (e) {
      log("Error while adding config for room",
          error: e, name: "[ $runtimeType -> addRoomConfig ]");
      return false;
    }
  }

  Future<List<Message>> getMessages({int pageSize = 10}) async {
    try {
      final List<Message> messages = [];
      int index = 0;
      for (; index < pageSize; index++) {
        final message = await getAtIndex(_lastPage);
        if (message == null) break;
        _lastPage++;
        messages.add(message);
      }
      return messages;
    } catch (e) {
      return [];
    }
  }

  Future<Message?> getAtIndex(int index) async {
    try {
      final res = await _hiveBox.getAt(index);
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
      _hiveBox.add(message.toJson());
      _lastPage++;
      return true;
    } catch (e) {
      log("Error while saving message", error: e);
      return false;
    }
  }
}
