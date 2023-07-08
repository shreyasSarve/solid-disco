part of chat_rooms;

class Room extends StatefulWidget {
  const Room({
    super.key,
    required this.chatRoom,
    this.isActiveChatRoom = false,
  });
  final ChatRoom chatRoom;
  final bool isActiveChatRoom;
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  Color bgColor = AppColors.backgroundColor;
  Color textColor = AppColors.textColor;
  bool isHoverd = false;
  @override
  void initState() {
    super.initState();
  }

  void onHover(bool hover) {
    isHoverd = hover;
    setState(() {});
  }

  void _hoverColor(bool hover) {
    if (widget.isActiveChatRoom) return;
    bgColor = hover ? AppColors.lightBackground : AppColors.backgroundColor;
    textColor = hover ? AppColors.textColor : AppColors.textColor;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActiveChatRoom) bgColor = AppColors.warningColor;
    _hoverColor(isHoverd);
    return Tooltip(
      message: widget.chatRoom.name,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      waitDuration: const Duration(seconds: 2),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          splashColor: AppColors.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          onHover: onHover,
          onTap: widget.isActiveChatRoom
              ? null
              : () {
                  final arg = MessageScreenArgs(room: widget.chatRoom);
                  final provider =
                      Provider.of<ChatScreenProvider>(context, listen: false);
                  provider.changeMessageScreen(arg);
                  provider.changeToMessageScreen();
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.errorColor.withOpacity(0.1),
                  radius: 15,
                  child: Text(
                    widget.chatRoom.name[0],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: AppTextTheme.bold.copyWith(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.chatRoom.name,
                  overflow: TextOverflow.fade,
                  style: AppTextTheme.regular.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
