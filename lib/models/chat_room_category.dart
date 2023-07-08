import 'package:commuication/models/chat_room.dart';

class ChatRoomCategory {
  final List<ChatRoom> _chatRooms = [];
  final String name;

  ChatRoomCategory(
    this.name,
  );

  bool addChatRoom(ChatRoom room) {
    bool doesExist = indexOfRoom(room.id) != -1;
    if (doesExist) return false;
    _chatRooms.add(room);
    return true;
  }

  bool deleteChatRoom(ChatRoom room) {
    int roomIndex = indexOfRoom(room.id);
    if (roomIndex == -1) return false;
    _chatRooms.removeAt(roomIndex);
    return true;
  }

  int indexOfRoom(String id) {
    return _chatRooms.map((e) => e.id).toList().indexOf(id);
  }

  List<ChatRoom> get rooms => _chatRooms;
}
