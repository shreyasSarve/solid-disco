part of share_screen;
// ignore_for_file: constant_identifier_names

class ShareScreenMobileView extends StatelessWidget {
  static const String KEY = "__ShareScreenMobileView__";

  const ShareScreenMobileView({super.key});

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
