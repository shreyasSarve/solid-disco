import 'dart:math' show pi;

import 'package:commuication/static/app_colors.dart';
import 'package:commuication/static/text_theme.dart';
import 'package:flutter/material.dart' hide TextTheme;

class SendButton extends StatefulWidget {
  final bool disable;
  const SendButton({
    super.key,
    this.disable = false,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onHover: (val) {},
      style: ElevatedButton.styleFrom(
        enableFeedback: true,
        backgroundColor: AppColors.sendButtonColor,
        disabledBackgroundColor: AppColors.sendButtonColor.withOpacity(0.5),
        disabledForegroundColor: AppColors.white.withOpacity(1),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 13,
        ),
      ),
      onPressed: !widget.disable ? null : widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Transform.rotate(
              angle: -pi / 5,
              origin: const Offset(-5, -5),
              child: const Icon(Icons.send_rounded),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Send",
              style: AppTextTheme.regular,
            ),
          ],
        ),
      ),
    );
  }
}
