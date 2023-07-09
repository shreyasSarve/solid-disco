import 'package:commuication/models/args/args.dart';
import 'package:commuication/models/args/no_args.dart';
import 'package:commuication/router/app_routes.dart';
import 'package:flutter/material.dart' hide Route;

class AppRoutesManager extends ChangeNotifier {
  late AppRoutes _route;
  Args _args = NoArgs();
  AppRoutesManager(AppRoutes initialRoute) {
    changeRoute(initialRoute);
  }

  void changeRoute(AppRoutes route, {Args? args}) {
    _route = route;
    _args = args ?? NoArgs();
    notifyListeners();
  }

  AppRoutes get currentRoute => _route;
  get args => _args;
}
