extension DateTimeExtention on DateTime {
  String getDate() {
    return "$hour:$minute";
  }
}
