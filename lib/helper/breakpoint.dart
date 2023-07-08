import 'package:commuication/models/screen_type.dart';
import 'package:flutter/material.dart';

class BreakPoint {
  static ScreenType getScreenType(Size size) {
    if (size.width > 750) return ScreenType.desktop;
    return ScreenType.mobile;
  }
}
