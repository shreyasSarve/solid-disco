part of share_screen;
// ignore_for_file: constant_identifier_names

class ShareScreenDesktopView extends StatelessWidget {
  static const String KEY = "__ShareScreenDesktopView__";

  const ShareScreenDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: AppColors.black,
                ),
              ),
            ),
            child: const AppSideNavbar(
              key: ValueKey(AppSideNavbar.KEY),
              initialIndex: 1,
            ),
          ),
          const Expanded(
            child: SharePage(),
          )
        ],
      ),
    );
  }
}
