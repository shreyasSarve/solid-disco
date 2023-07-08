part of chat_screen;
// ignore_for_file: constant_identifier_names

class ChatScreenDesktopView extends StatelessWidget {
  static const String KEY = "__ChatScreenDesktopView__";

  const ChatScreenDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ChatRoomsScreen(
              key: ValueKey(ChatRoomsScreen.KEY),
            ),
          ),
          Expanded(
            flex: 5,
            child: MessagePage(
              screenType: ScreenType.desktop,
              key: ValueKey(MessagePage.KEY),
            ),
          ),
        ],
      ),
    );
  }
}
