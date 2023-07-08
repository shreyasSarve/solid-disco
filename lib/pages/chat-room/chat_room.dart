part of chat_rooms;

class Room extends StatefulWidget {
  const Room({
    super.key,
    required this.chatRoom,
  });
  final ChatRoom chatRoom;
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  Color bgColor = AppColors.backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        splashColor: AppColors.backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        onHover: (hover) {
          bgColor =
              hover ? AppColors.lightBackground : AppColors.backgroundColor;
          setState(() {});
        },
        onTap: () {
          final arg = MessageScreenArgs(roomName: widget.chatRoom.name);
          final provider =
              Provider.of<ChatScreenProvider>(context, listen: false);
          provider.changeMessageScreen(arg);
          provider.changeToMessageScreen();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.1),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
