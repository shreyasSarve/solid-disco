import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/conf/args.dart';

class MessageScreenArgs extends Args {
  final ChatRoom room;
  MessageScreenArgs({
    required this.room,
  });
}
