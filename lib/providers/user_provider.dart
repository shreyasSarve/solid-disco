import 'dart:io';

import 'package:commuication/models/user.dart';

class UserProvider {
  static bool isCurrentUser(User user) {
    return user == thisMachineUser();
  }

  static User thisMachineUser() {
    if (Platform.isAndroid) return User.phone;
    return User.laptop;
  }
}
