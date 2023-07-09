import 'dart:developer';

import 'package:commuication/models/chat_room.dart';
import 'package:hive/hive.dart';

class ChatRoomsService {
  late Box _chatRoomBox;

  Future init() async {
    _chatRoomBox = await Hive.openBox(ChatRoom.key);
  }

  Future<bool> createNewChatRoom(ChatRoom room) async {
    try {
      if (_chatRoomBox.containsKey(room.id)) {
        throw Exception("Chat Room already exist");
      }
      _chatRoomBox.put(room.id, room.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ChatRoom>> getAllChatRooms() async {
    try {
      final allRooms = _chatRoomBox.values.toList();
      inspect(allRooms);
      return allRooms.map((json) => ChatRoom.fromJson(json)).toList();
    } catch (e) {
      log("Error", error: e);
      return [];
    }
  }
}
