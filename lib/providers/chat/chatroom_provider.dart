import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/chat_room_category.dart';
import 'package:flutter/widgets.dart';

class ChatRoomScreenProvider extends ChangeNotifier {
  final List<ChatRoomCategory> _categories = [];

  ChatRoomScreenProvider() {
    favouriteRoom.addChatRoom(chatRoom1);
    favouriteRoom.addChatRoom(chatRoom2);
    favouriteRoom.addChatRoom(chatRoom3);
    favouriteRoom.addChatRoom(chatRoom4);

    personalRoom.addChatRoom(chatRoom1);
    personalRoom.addChatRoom(chatRoom2);
    personalRoom.addChatRoom(chatRoom3);
    personalRoom.addChatRoom(chatRoom4);

    _categories.add(favouriteRoom);
    _categories.add(personalRoom);
  }

  List<ChatRoomCategory> get categories => _categories;
}

final ChatRoom chatRoom1 = ChatRoom(name: "Personal", id: "#12345");
final ChatRoom chatRoom2 = ChatRoom(name: "Personal - 1", id: "#12346");
final ChatRoom chatRoom3 = ChatRoom(name: "Personal - 2", id: "#12347");
final ChatRoom chatRoom4 = ChatRoom(name: "Personal - 3", id: "#12348");
final favouriteRoom = ChatRoomCategory("FAVOURITES");
final personalRoom = ChatRoomCategory("PERSONAL");
