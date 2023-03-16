import 'package:code_hero_project/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final navigator = navigatorKey.currentState!;

class Routes {
  final List<ChildRoute> routes = [
    ChildRoute(
      NamedRoutes.HOME,
      child: (_, __) => const HomePage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}

class NamedRoutes {
  static const HOME = "/home";
}
