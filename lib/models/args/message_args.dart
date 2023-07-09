import 'package:commuication/models/args/args.dart';
import 'package:commuication/models/chat_room.dart';

class MessageScreenArgs extends Args {
  final ChatRoom room;
  MessageScreenArgs({
    required this.room,
  });
}
