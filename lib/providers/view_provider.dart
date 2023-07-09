import 'package:flutter/material.dart';

enum View { chat, share }

class ViewProvider extends ChangeNotifier {
  View _view = View.chat;

  void changeView(View view) {
    _view = view;
    notifyListeners();
  }

  View get view => _view;
}
