import 'package:commuication/models/args/message_args.dart';
import 'package:commuication/providers/chat/chatroom_provider.dart';
import 'package:commuication/providers/chat/message_screen_provider.dart';
import 'package:flutter/widgets.dart';

enum ChatScreens { message, chatrooms }

class ChatScreenProvider extends ChangeNotifier {
  ChatScreens _chatScreen = ChatScreens.chatrooms;
  final MessagePageProvider _messagePageProvider = MessagePageProvider();
  final ChatRoomScreenProvider _chatRoomScreenProvider =
      ChatRoomScreenProvider();
  void changeChatScreen(ChatScreens screen) {
    _chatScreen = screen;
    notifyListeners();
  }

  void back() {
    changeChatScreen(ChatScreens.chatrooms);
  }

  void changeMessageScreen(MessageScreenArgs args) {
    _chatRoomScreenProvider.changeActiveChatRoom(args.room.id);
    _messagePageProvider.changeChatRoom(args);
    notifyListeners();
  }

  void changeToMessageScreen() {
    changeChatScreen(ChatScreens.message);
  }

  void deleteRoom(String id) async {
    if (await _messagePageProvider.deleteRoom(id: id)) {
      _chatRoomScreenProvider.deleteChatRoom(id);
    }
  }

  ChatScreens get currentScreen => _chatScreen;
  MessagePageProvider get messageScreenProvider => _messagePageProvider;
  ChatRoomScreenProvider get chatRoomsScreenProvider => _chatRoomScreenProvider;
}
