class Message {
  final String text;
  late final DateTime dateTime;
  final User user;
  Message({
    required this.text,
    DateTime? dateTime,
    required this.user,
  }) : dateTime = dateTime ?? DateTime.now();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      user: _fromString(json['user']),
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'user': user.name,
      'dateTime': dateTime,
    };
  }

  static User _fromString(String user) {
    switch (user.toLowerCase()) {
      case 'laptop':
        return User.laptop;
      case 'mobile':
        return User.phone;
      default:
        return User.phone;
    }
  }
}

enum User { phone, laptop }

extension UserExtention on User {}
