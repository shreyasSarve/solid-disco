// ignore_for_file: constant_identifier_names

library chat_rooms;

import 'package:commuication/models/chat_room.dart';
import 'package:commuication/models/chat_room_category.dart';
import 'package:commuication/models/conf/message_args.dart';
import 'package:commuication/providers/chat/chat_screen_provider.dart';
import 'package:commuication/providers/chat/chatroom_provider.dart';
import 'package:commuication/static/app_colors.dart';
import 'package:commuication/static/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part './chat_room.dart';
part './room_category.dart';

class ChatRoomsScreen extends StatefulWidget {
  static const String KEY = "__ChatRoomsScreen__";

  const ChatRoomsScreen({super.key});

  @override
  State<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.05,
            color: AppColors.white,
          ),
        ),
      ),
      child: Selector<ChatRoomScreenProvider, List<ChatRoomCategory>>(
          selector: (_, provider) => provider.categories,
          builder: (context, categories, child) {
            return LayoutBuilder(
              builder: (context, constraints) => ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 5,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return AppBar(
                      title: const Text(
                        "Chat Rooms",
                      ),
                      backgroundColor: AppColors.backgroundColor,
                      elevation: 0,
                      shadowColor: AppColors.white,
                    );
                  }
                  return RoomCategory(
                    roomCategory: categories[index - 1],
                  );
                },
                itemCount: categories.length + 1,
              ),
            );
          }),
    );
  }
}
