import 'package:slc_app/app/modules/splash/splash_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slc_app/app/modules/splash/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
