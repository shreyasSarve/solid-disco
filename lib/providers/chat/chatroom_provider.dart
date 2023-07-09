import 'dart:async';
import 'dart:developer';

import 'package:commuication/models/chat_room.dart';
import 'package:commuication/services/room_serive.dart';
import 'package:flutter/widgets.dart';

class ChatRoomScreenProvider extends ChangeNotifier {
  final List<ChatRoom> _categories = [];
  final StreamData<List<ChatRoom>, ChatRoom> _streamData = StreamData(
    initialData: [],
    onAdd: _onAdd,
    onDelete: _onDelete,
  );
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
    _streamData.delete(id);
    changeActiveChatRoom("");
  }

  static List<ChatRoom> _onDelete<String>(List<ChatRoom> data, String id) {
    data.removeWhere((element) => element.id == id);
    return data;
  }

  static List<ChatRoom> _onAdd<ChatRoom>(List<ChatRoom> data, ChatRoom room) {
    data.add(room);
    return data;
  }

  void addNewChatRoom(String name) async {
    try {
      final room = ChatRoom(
        name: name,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      if (await _service.createNewChatRoom(room)) {
        _categories.add(room);
        _streamData.add(room);
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
      for (var room in rooms) {
        _streamData.add(room);
      }
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
  Stream<List<ChatRoom>> get stream => _streamData.stream;
}

enum DataState { loading, error, success }

/*
class StreamData<T> {
  final List<T> _data;
  final Function()
  final StreamController<List<T>> _controller = StreamController();
  StreamData({required List<T> initialData,}) : _data = initialData;

  void add(T data) {
    _data.add(data);
    sink.add(_data);
  }

  void deleteAt(int index) {
    _data.removeAt(index);
    sink.add(_data);
  }
  void deleteData(T data)
  {
    int index=_data.indexOf(data);
    if(index!=-1) {
      deleteAt(index);
    }
  }
  StreamSink<List<T>> get sink => _controller.sink;
  Stream<List<T>> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}

*/

class StreamData<T, P> {
  final T _data;
  final T Function(T currentData, P newData) onAdd;
  final T Function<K>(T currentData, K deleteData) onDelete;

  final StreamController<T> _controller = StreamController();
  StreamData({
    required T initialData,
    required this.onAdd,
    required this.onDelete,
  }) : _data = initialData;

  void add(P data) {
    onAdd(_data, data);
    sink.add(_data);
  }

  void delete(dynamic data) {
    onDelete(_data, data);
    sink.add(_data);
  }

  StreamSink<T> get sink => _controller.sink;
  Stream<T> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
