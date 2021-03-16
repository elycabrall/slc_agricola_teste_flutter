import 'package:slc_app/app/modules/home/widgets/item_detalhe/item_detalhe_bloc.dart';
import 'package:slc_app/app/modules/home/widgets/drawer/drawer_bloc.dart';
import 'package:slc_app/app/modules/home/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slc_app/app/modules/home/home_page.dart';

import 'pages/fale_conosco/fale_conosco_bloc.dart';
import 'pages/fale_conosco/fale_conosco_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FaleConoscoBloc()),
        Bind((i) => ItemDetalheBloc()),
        Bind((i) => DrawerBloc()),
        Bind((i) => HomeBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/fale-conosco', child: (_, args) => FaleConoscoPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
