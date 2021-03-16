import 'package:slc_app/app/shared/widgets/modal_alerta/modal_alerta_bloc.dart';
import 'package:slc_app/app/shared/widgets/button_border/button_border_bloc.dart';
import 'package:slc_app/app/shared/widgets/button_link/button_link_bloc.dart';
import 'package:slc_app/app/shared/widgets/button_solid/button_solid_bloc.dart';
import 'package:slc_app/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:slc_app/app/app_widget.dart';
import 'package:slc_app/app/modules/home/home_module.dart';

import 'modules/onboard/onboard_module.dart';
import 'modules/splash/splash_module.dart';
import 'shared/blocs/resultado/resultado_bloc.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ResultadoBloc()),
        Bind((i) => ModalAlertaBloc()),
        Bind((i) => ButtonBorderBloc()),
        Bind((i) => ButtonLinkBloc()),
        Bind((i) => ButtonSolidBloc()),
        Bind((i) => AppBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/onboard', module: OnboardModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
