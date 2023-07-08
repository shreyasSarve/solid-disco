// ignore_for_file: constant_identifier_names
part of chat_screen;

class ChatScreenMobileView extends StatelessWidget {
  static const String KEY = "__ChatScreenMobileView__";

  const ChatScreenMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Selector<ChatScreenProvider, ChatScreens>(
        selector: (context, provider) => provider.currentScreen,
        builder: (context, value, child) {
          switch (value) {
            case ChatScreens.message:
              return const MessagePage(
                screenType: ScreenType.mobile,
                key: ValueKey(MessagePage.KEY),
              );
            case ChatScreens.chatrooms:
              return const ChatRoomsScreen();
          }
        },
      ),
    );
  }
}
