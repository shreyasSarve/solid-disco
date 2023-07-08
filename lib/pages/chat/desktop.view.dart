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
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 10,
              // horizontal: 10,
            ),
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border(
                right: BorderSide(
                  width: 0.05,
                  color: AppColors.white,
                ),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                NavBarIcon(
                  isActive: true,
                  showText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                NavBarIcon(
                  isActive: false,
                  showText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                NavBarIcon(
                  isActive: false,
                  showText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                NavBarIcon(
                  isActive: false,
                  showText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                NavBarIcon(
                  isActive: false,
                  showText: false,
                ),
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

class NavBarIcon extends StatefulWidget {
  const NavBarIcon({super.key, required this.isActive, this.showText = true});
  final bool isActive;
  final bool showText;
  @override
  State<NavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<NavBarIcon> {
  late Color? bgcolor;
  late Color? textColor;
  late Color? iconColor;
  @override
  void initState() {
    super.initState();
    initialConf();
  }

  void initialConf() {
    bgcolor = widget.isActive ? null : Colors.transparent;
    textColor = widget.isActive ? AppColors.white : AppColors.lightBackground;
    iconColor =
        widget.isActive ? AppColors.sendButtonColor : AppColors.lightBackground;
  }

  void onHover() {
    if (widget.isActive) return;
    bgcolor = AppColors.lightBackground;
    textColor = AppColors.white;
    iconColor = AppColors.white;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (val) {
        if (val) {
          onHover();
        } else {
          initialConf();
          setState(() {});
        }
      },
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        decoration: BoxDecoration(
          // color: widget.isActive ? AppColors.sendButtonColor : null,
          // borderRadius: BorderRadius.circular(5),
          color: bgcolor,
          border: widget.isActive
              ? const Border(
                  right: BorderSide(
                    color: AppColors.sendButtonColor,
                  ),
                )
              : null,
          borderRadius: widget.isActive
              ? null
              : BorderRadius.circular(
                  2,
                ),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              Icons.send_to_mobile,
              color: iconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            if (widget.showText)
              Text(
                "Message",
                style: AppTextTheme.regular.copyWith(
                  letterSpacing: 1,
                  color: textColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
