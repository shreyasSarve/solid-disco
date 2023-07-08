part of message_page;

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    final bgColor = isCurrentUser(message.user)
        ? AppColors.lightBackground
        : Colors.green.shade500.withOpacity(0.1);
    final textColor =
        !isCurrentUser(message.user) ? AppColors.white : Colors.green.shade500;
    final crossAlignment = !isCurrentUser(message.user)
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;
    const double margin = 100;
    final oppositeMargin = !isCurrentUser(message.user)
        ? const EdgeInsets.only(right: margin)
        : const EdgeInsets.only(left: margin);
    return Container(
      padding: oppositeMargin,
      child: Column(
        crossAxisAlignment: crossAlignment,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: textColor,
                width: 0.3,
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: SelectableText(
              showCursor: false,
              message.text,
              style: TextStyle(
                fontFamily: Fonts.regular,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (message.user == User.laptop) laptopUser() else phoneUser()
        ],
      ),
    );
  }

  Widget user(User user) {
    final icon =
        User.phone == user ? Icons.phone_android_rounded : Icons.laptop;
    return CircleAvatar(
      radius: 10,
      backgroundColor: AppColors.black,
      child: Icon(
        icon,
        size: 10,
        color: AppColors.white,
      ),
    );
  }

  Widget laptopUser() {
    final alignment = !isCurrentUser(message.user)
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;
    return DefaultTextStyle(
      style: AppTextTheme.regular,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          user(User.laptop),
          const SizedBox(
            width: 5,
          ),
          const Text("Lapi"),
          const SizedBox(
            width: 5,
          ),
          Text(
            message.dateTime.getDate(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  Widget phoneUser() {
    final alignment = !isCurrentUser(message.user)
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;
    return Row(
      mainAxisAlignment: alignment,
      children: [
        const SizedBox(
          width: 5,
        ),
        Text(
          message.dateTime.getDate(),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text("You"),
        const SizedBox(
          width: 5,
        ),
        user(User.phone),
      ],
    );
  }
}
