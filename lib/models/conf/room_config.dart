class RoomConfig {
  static const key = "__config__";
  String roomname;
  String roomId;
  int pages;

  RoomConfig({
    required this.roomname,
    required this.roomId,
    this.pages = 0,
  });

  factory RoomConfig.fromJson(Map<String, dynamic> json) {
    return RoomConfig(
      roomname: json['roomname'],
      roomId: json['roomId'],
      pages: json['pages'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "roomname": roomname,
      "roomId": roomId,
      "pages": pages,
    };
  }
}
