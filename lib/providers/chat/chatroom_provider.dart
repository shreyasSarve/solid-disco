import 'dart:developer';

import 'package:commuication/models/chat_room.dart';
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

  void deleteChatRoom(String id) async {
    await _service.deleteRoom(id);
    _categories.removeWhere((element) => element.id == id);
    inspect(_categories);
    changeActiveChatRoom("");
  }

  void addNewChatRoom(String name) async {
    try {
      final room = ChatRoom(
        name: name,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      if (await _service.createNewChatRoom(room)) {
        _categories.add(room);
        notifyListeners();
      }
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

enum DataState { loading, error, success }
