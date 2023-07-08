import 'package:commuication/static/app_colors.dart';
import 'package:commuication/widgets/navbar/navbar_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({
    super.key,
    required this.onChanged,
    required this.items,
  });
  final Function(int index) onChanged;
  final List<NavbarItem> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Builder(
        builder: (context) {
          final provider = _NavbarProvider(
            intialActiveIndex: 0,
            onChanged: onChanged,
          );

          Widget buildItem(int index, int activeIndex) {
            return Column(
              children: [
                NavBarIcon(
                  isActive: index == activeIndex,
                  item: items[index],
                  onPressed: (item) {
                    provider.changeActiveIndex(
                      index,
                    );
                  },
                  isHover: provider.hoverIndex == index,
                  onHover: (val, item) {
                    if (val) {
                      provider.chnageHoverIndex(index);
                    } else {
                      provider.changeActiveIndex(provider.activeIndex);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }

          return ChangeNotifierProvider.value(
            value: provider,
            child: Consumer<_NavbarProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    for (int index = 0; index < items.length; index++)
                      buildItem(index, provider.activeIndex)
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _NavbarProvider extends ChangeNotifier {
  int _currentActiveIndex;
  int _hoverIndex;
  final void Function(int index)? onChanged;
  _NavbarProvider({
    required int intialActiveIndex,
    this.onChanged,
  })  : _currentActiveIndex = intialActiveIndex,
        _hoverIndex = intialActiveIndex;

  void changeActiveIndex(int index) {
    if (index == _currentActiveIndex) return;
    _currentActiveIndex = index;
    notifyListeners();
    onChanged?.call(index);
  }

  void chnageHoverIndex(int index) {
    if (index == _hoverIndex) return;
    _hoverIndex = index;
    notifyListeners();
  }

  int get activeIndex => _currentActiveIndex;
  int get hoverIndex => _hoverIndex;
}

class NavbarItem {
  String label;
  IconData activeIcon;
  IconData? inActiveIcon;
  NavbarItem({
    required this.label,
    required this.activeIcon,
    this.inActiveIcon,
  });
}
