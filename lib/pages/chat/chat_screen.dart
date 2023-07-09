library chat_screen;

import 'package:commuication/helper/breakpoint.dart';
import 'package:commuication/models/screen_type.dart';
import 'package:commuication/pages/chat-room/chat_rooms_screen.dart';
import 'package:commuication/pages/message/message_page.dart';
import 'package:commuication/pages/page.dart';
import 'package:commuication/providers/chat/chat_screen_provider.dart';
import 'package:commuication/static/app_colors.dart';
import 'package:commuication/widgets/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part './desktop.view.dart';
part './mobile.view.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ChatScreenProvider _provider = ChatScreenProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _provider.messageScreenProvider),
          ChangeNotifierProvider.value(
            value: _provider.chatRoomsScreenProvider,
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenType =
                BreakPoint.getScreenType(MediaQuery.of(context).size);
            switch (screenType) {
              case ScreenType.desktop:
                return const ChatScreenDesktopView(
                  key: ValueKey(ChatScreenDesktopView.KEY),
                );
              case ScreenType.mobile:
                return const ChatScreenMobileView(
                  key: ValueKey(ChatScreenMobileView.KEY),
                );
            }
          },
        ),
      ),
    );
  }
}
