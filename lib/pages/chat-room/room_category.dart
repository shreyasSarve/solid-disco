part of chat_rooms;

class RoomCategory extends StatefulWidget {
  const RoomCategory({
    super.key,
    required this.roomCategory,
  });
  final List<ChatRoom> roomCategory;
  @override
  State<RoomCategory> createState() => _RoomCategoryState();
}

class _RoomCategoryState extends State<RoomCategory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextTheme.light.copyWith(
        color: Colors.white,
        letterSpacing: 1,
      ),
      child: Consumer<ChatRoomScreenProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(
              //     horizontal: 50,
              //     vertical: 10,
              //   ),
              //   child: Text(
              //     "FAVOURITES",
              //     style: AppTextTheme.regular.copyWith(
              //       color: Colors.grey,
              //       fontSize: 12,
              //     ),
              //   ),
              // ),
              for (final room in widget.roomCategory)
                Room(
                  chatRoom: room,
                  isActiveChatRoom: value.activeRoomId == room.id,
                )
            ],
          );
        },
      ),
    );
  }
}
