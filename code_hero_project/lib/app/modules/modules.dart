import 'package:code_hero_project/app/pages/home/home_controller.dart';
import 'package:code_hero_project/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  Routes myRoutes = Routes();

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HomeController()),
      ];

  @override
  List<ModularRoute> get routes => [...myRoutes.routes];
}
