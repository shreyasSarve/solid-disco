// ignore_for_file: constant_identifier_names

import 'package:commuication/providers/view_provider.dart';
import 'package:commuication/widgets/navbar/navbar.dart';
import 'package:flutter/material.dart' hide View;
import 'package:provider/provider.dart';

class AppSideNavbar extends StatefulWidget {
  static const String KEY = "__AppSideNavbar__";
  const AppSideNavbar({
    super.key,
    this.initialIndex = 0,
  });
  final int initialIndex;
  @override
  State<AppSideNavbar> createState() => _AppSideNavbarState();
}

class _AppSideNavbarState extends State<AppSideNavbar> {
  @override
  Widget build(BuildContext context) {
    return SideNavbar(
      activeIndex: widget.initialIndex,
      key: const ValueKey("__SideNavbar__"),
      onChanged: (index) {
        Provider.of<ViewProvider>(context, listen: false).changeView(
          View.values[index],
        );
      },
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
    );
  }
}
