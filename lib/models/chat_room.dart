class ChatRoom {
  static const key = "__ChatRooms__";
  String name;
  String id;
  ChatRoom({
    required this.name,
    required this.id,
  });
  factory ChatRoom.fromJson(Map<dynamic, dynamic> json) {
    return ChatRoom(
      name: json["name"],
      id: json["id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
    };
  }
}

class NoChatRoom extends ChatRoom {
  NoChatRoom() : super(id: "__noChatRoom__", name: "Chat Room");
}
