import 'package:code_hero_project/app/modules/modules.dart';
import 'package:code_hero_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(NamedRoutes.HOME);

    return MaterialApp.router(
      title: 'Busca Marvel Project',
      theme: ThemeData(
        fontFamily: 'boboto-black',
        primarySwatch: Colors.red,
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
