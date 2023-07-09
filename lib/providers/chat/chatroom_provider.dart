import 'dart:developer';

import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/chat_room_category.dart';
import 'package:commuication/services/room_serive.dart';
import 'package:flutter/widgets.dart';

class ChatRoomScreenProvider extends ChangeNotifier {
  final List<ChatRoom> _categories = [];
  String _activeChatRoomId = "";
  final ChatRoomsService _service = ChatRoomsService();
  DataState _state = DataState.loading;
  ChatRoomScreenProvider() {
    _init();
  }
  void _init() async {
    await _service.init();
    _getAllChatRooms();
  }

  void changeActiveChatRoom(String roomId) {
    _activeChatRoomId = roomId;
    notifyListeners();
  }

  void addNewChatRoom(String name) async {
    try {
      final room = ChatRoom(
        name: name,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      if (await _service.createNewChatRoom(room)) _categories.add(room);
      notifyListeners();
    } catch (e) {
      log(
        "Error occored while creating new chat room",
        error: e,
      );
    }
  }

  void _getAllChatRooms() async {
    try {
      final rooms = await _service.getAllChatRooms();
      for (var element in rooms) {
        favouriteRoom.addChatRoom(element);
      }
      _categories.addAll(rooms);
      _setDataState(DataState.success);
      notifyListeners();
    } catch (e) {
      _setDataState(DataState.error);
    }
  }

  void _setDataState(DataState state) {
    _state = state;
    notifyListeners();
  }

  List<ChatRoom> get categories => _categories;
  String get activeRoomId => _activeChatRoomId;
  DataState get state => _state;
}

final ChatRoom chatRoom1 = ChatRoom(name: "Personal", id: "#12345");
final ChatRoom chatRoom2 = ChatRoom(name: "Personal - 1", id: "#12346");
final ChatRoom chatRoom3 = ChatRoom(name: "Personal - 2", id: "#12347");
final ChatRoom chatRoom4 = ChatRoom(name: "Personal - 3", id: "#12348");
final favouriteRoom = ChatRoomCategory("FAVOURITES");
final personalRoom = ChatRoomCategory("PERSONAL");

enum DataState { loading, error, success }
