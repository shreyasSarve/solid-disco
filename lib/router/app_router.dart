import 'package:commuication/pages/chat-room/chat_rooms_screen.dart';
import 'package:commuication/pages/chat/chat_screen.dart';
import 'package:commuication/pages/page.dart';
import 'package:commuication/router/app_routes.dart';
import 'package:commuication/router/app_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer<AppRoutesManager>(
        builder: (context, provider, child) {
          switch (provider.currentRoute) {
            case AppRoutes.Chat_Room_Mobile:
              return const ChatRoomsScreen(
                key: ValueKey("__ChatRoomScreen__"),
              );
            case AppRoutes.Home_Desktop:
            case AppRoutes.Message_Desktop:
            default:
              return ChatScreen(
                key: const ValueKey("__ChatScreen__"),
              );
          }
        },
        // selector: (context, provider) => provider.currentRoute,
      ),
    );
  }
}
