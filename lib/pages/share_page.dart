import 'package:commuication/static/app_colors.dart';
import 'package:commuication/static/text_theme.dart';
import 'package:flutter/material.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(
            width: 40,
          ),
          _buildIcon()
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return ShareScreenButtons();
  }
}

class ShareScreenButtons extends StatefulWidget {
  const ShareScreenButtons({
    super.key,
  });

  @override
  State<ShareScreenButtons> createState() => _ShareScreenButtonsState();
}

class _ShareScreenButtonsState extends State<ShareScreenButtons> {
  bool isHover = false;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            isActive = !isActive;
            setState(() {});
          },
          onHover: (val) {
            isHover = val;
            setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isHover || isActive
                  ? AppColors.secondaryColor
                  : AppColors.accentColor,
              borderRadius: BorderRadius.circular(isHover || isActive ? 10 : 5),
            ),
            padding: const EdgeInsets.all(15),
            child: Icon(
              Icons.share_location_rounded,
              color: isHover || isActive
                  ? AppColors.white
                  : AppColors.successColor,
              size: 100,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (isHover)
          Text(
            "Send",
            style: AppTextTheme.regular.copyWith(
              fontSize: 15,
            ),
          )
      ],
    );
  }
}
