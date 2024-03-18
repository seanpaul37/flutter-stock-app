// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/windows/security/FirstScreen.dart';
import 'package:stock_app/windows/security/SecurityScreen.dart';

import '../windows/home/HomeScreen.dart';

class RouterGenerator {
  static const securityRoute = "/";
  static const firstRoute = "/first";
  static const homeRoute = "/home";

  static Route<dynamic> navigate(RouteSettings setting) {
    if (kDebugMode) {
      log(setting.toString(), name: "RouterGenerator");
    }

    switch (setting.name) {
      case RouterGenerator.securityRoute:
        return MaterialPageRoute(
          builder: (_) => const SecurityScreen(),
        );
      case RouterGenerator.firstRoute:
        return MaterialPageRoute(
          builder: (_) => const FirstScreen(),
        );
      case RouterGenerator.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            payloads: setting.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SecurityScreen(),
        );
    }
  }
}
