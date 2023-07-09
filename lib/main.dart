import 'dart:io';

import 'package:commuication/models/user.dart';
import 'package:commuication/providers/view_provider.dart';
import 'package:commuication/router/app_router.dart';
import 'package:commuication/router/app_routes.dart';
import 'package:commuication/router/app_routes_manager.dart';
import 'package:commuication/static/fonts.dart';
import 'package:commuication/static/themes.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRoutes getInitialRoute() {
    if (Platform.isAndroid) return AppRoutes.Chat_Room_Mobile;
    return AppRoutes.Message_Desktop;
  }

  User getUser() {
    if (Platform.isAndroid) {
      return User.phone;
    }
    return User.laptop;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppRoutesManager(getInitialRoute()),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewProvider(),
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
