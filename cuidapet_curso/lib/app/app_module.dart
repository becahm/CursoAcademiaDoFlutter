import 'package:cuidapet_curso/app/modules/home/home_module.dart';
import 'package:cuidapet_curso/app/modules/login/login_module.dart';
import 'package:cuidapet_curso/app/modules/main/main_page.dart';
import 'package:cuidapet_curso/app/shared/auth_store.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MainPage(),
        ),
        ModularRouter(
          HomeModule.route,
          module: HomeModule(),
        ),
        ModularRouter(
          LoginModule.route,
          module: LoginModule(),
        )
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
