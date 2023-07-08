enum ScreenType { desktop, mobile }

extension ScreenExnteion on ScreenType {
  String get name {
    switch (this) {
      case ScreenType.mobile:
        return "mobile";
      case ScreenType.desktop:
        return "desktop";
    }
  }
}
