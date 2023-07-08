import 'package:commuication/static/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends Scaffold {
  const AppScaffold({
    super.body,
    super.backgroundColor = AppColors.backgroundColor,
    super.key,
  });
}

class DummyScaffold extends Container {
  DummyScaffold({
    super.key,
    AppBar? appBar,
    Widget? body,
    Color backgroundColor = AppColors.backgroundColor,
  }) : super(
          child: Column(
            children: [
              if (appBar != null) appBar,
              if (body != null) body,
            ],
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
        );
}
