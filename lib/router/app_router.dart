import 'package:commuication/pages/chat/chat_screen.dart';
import 'package:commuication/pages/page.dart';
import 'package:commuication/pages/share/share_screen.dart';
import 'package:commuication/providers/view_provider.dart';
import 'package:flutter/material.dart' hide View;
import 'package:provider/provider.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer<ViewProvider>(
        builder: (context, provider, child) {
          switch (provider.view) {
            case View.chat:
              return ChatScreen(
                key: const ValueKey("__ChatScreen__"),
              );
            case View.share:
              return ShareScreen(
                key: const ValueKey("__ShareScreen__"),
              );
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
