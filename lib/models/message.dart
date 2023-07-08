class Message {
  final String text;
  late final DateTime dateTime;
  final User user;
  Message({required this.text, DateTime? dateTime, required this.user})
      : dateTime = dateTime ?? DateTime.now();
}

enum User { phone, laptop }
