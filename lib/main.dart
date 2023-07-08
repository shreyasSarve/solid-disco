import 'dart:io';

import 'package:commuication/models/message.dart';
import 'package:commuication/router/app_router.dart';
import 'package:commuication/router/app_routes.dart';
import 'package:commuication/router/app_routes_manager.dart';
import 'package:commuication/static/fonts.dart';
import 'package:commuication/static/themes.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

const thisMachineUser = User.phone;
bool isCurrentUser(User user) {
  return user == thisMachineUser;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  AppRoutes getInitialRoute() {
    if (Platform.isAndroid) return AppRoutes.Chat_Room_Mobile;
    return AppRoutes.Message_Desktop;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppRoutesManager(getInitialRoute()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Communication',
        theme: ThemeData(
          fontFamily: Fonts.regular,
          textTheme: Themes.textTheme,
        ),
        home: const AppRouter(),
      ),
    );
  }
}
