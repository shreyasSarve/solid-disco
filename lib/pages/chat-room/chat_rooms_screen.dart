// ignore_for_file: constant_identifier_names

library chat_rooms;

import 'dart:developer';

import 'package:commuication/models/args/message_args.dart';
import 'package:commuication/models/chat_room.dart';
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
  late final ChatRoomScreenProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<ChatScreenProvider>(context, listen: false)
        .chatRoomsScreenProvider;
  }

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
      child: LayoutBuilder(
        builder: (context, constraints) => ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(
            height: 5,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    splashColor: AppColors.accentColor,
                    icon: const Icon(
                      Icons.add_circle,
                      color: AppColors.successColor,
                    ),
                  )
                ],
                title: const Text(
                  "Chat Rooms",
                ),
                backgroundColor: AppColors.backgroundColor,
                elevation: 0,
                shadowColor: AppColors.white,
              );
            }
            if (index == 1) {
              return const _ChatRoomSearchField(
                key: ValueKey("__ChatRoomSearchField__"),
              );
            }
            return StreamBuilder(
              stream: provider.stream,
              builder: (context, snapshot) {
                return RoomCategory(
                  roomCategory: snapshot.data ?? [],
                );
              },
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}

class _ChatRoomSearchField extends StatefulWidget {
  const _ChatRoomSearchField({
    super.key,
  });

  @override
  State<_ChatRoomSearchField> createState() => _ChatRoomSearchFieldState();
}

class _ChatRoomSearchFieldState extends State<_ChatRoomSearchField> {
  final controller = TextEditingController();
  late final ChatRoomScreenProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<ChatRoomScreenProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              border: Border.all(
                color: AppColors.black,
                width: 0.01,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.white,
              cursorRadius: const Radius.circular(5),
              cursorHeight: 20,
              onFieldSubmitted: (value) {
                if (value.trim().isEmpty) return;
                provider.addNewChatRoom(value);
                controller.clear();
              },
              decoration: const InputDecoration(
                hintText: "Search room",
                hintStyle: AppTextTheme.light,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const Text(
            "Enter to create chat room",
            style: AppTextTheme.light,
          )
        ],
      ),
    );
  }
}
