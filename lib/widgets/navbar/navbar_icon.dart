import 'package:commuication/static/app_colors.dart';
import 'package:commuication/widgets/navbar/navbar.dart';
import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.isActive,
    required this.item,
    required this.onPressed,
    this.isHover = false,
    this.onHover,
  });
  final bool isActive;
  final bool isHover;
  final NavbarItem item;
  final Function(NavbarItem item) onPressed;
  final Function(bool val, NavbarItem item)? onHover;
  void initialConf() {}

  @override
  Widget build(BuildContext context) {
    Color bgcolor = isActive
        ? AppColors.secondaryColor
        : isHover
            ? AppColors.accentColor
            : Colors.transparent;
    Color iconColor =
        !isActive ? AppColors.secondaryColor : AppColors.backgroundColor;
    return InkWell(
      onHover: (val) {
        onHover?.call(val, item);
      },
      onTap: () {
        onPressed(item);
      },
      child: Tooltip(
        message: item.label,
        enableFeedback: true,
        margin: const EdgeInsets.only(left: 50),
        waitDuration: const Duration(microseconds: 1000),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          padding: const EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgcolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    isActive || isHover
                        ? item.activeIcon
                        : item.inActiveIcon ?? item.activeIcon,
                    color: iconColor,
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
