import 'package:commuication/models/conf/message_args.dart';
import 'package:flutter/material.dart';

class MessagePageProvider extends ChangeNotifier {
  MessageScreenArgs _args = MessageScreenArgs(roomName: "Chat Room");

  void changeChatRoom(MessageScreenArgs args) {
    _args = args;
    notifyListeners();
  }

  MessageScreenArgs get args => _args;
}
