part of chat_screen;
// ignore_for_file: constant_identifier_names

class ChatScreenDesktopView extends StatelessWidget {
  static const String KEY = "__ChatScreenDesktopView__";

  const ChatScreenDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: AppColors.black,
                ),
              ),
            ),
            child: SideNavbar(
              onChanged: (index) {},
              items: [
                NavbarItem(
                  label: "Message",
                  activeIcon: Icons.chat_bubble,
                  inActiveIcon: Icons.chat_bubble_outline_rounded,
                ),
                NavbarItem(
                  label: "Share",
                  activeIcon: Icons.share_rounded,
                  inActiveIcon: Icons.share_outlined,
                )
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: ChatRoomsScreen(
              key: ValueKey(ChatRoomsScreen.KEY),
            ),
          ),
          const Expanded(
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
