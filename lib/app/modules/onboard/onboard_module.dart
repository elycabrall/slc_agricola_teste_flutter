import 'package:slc_app/app/modules/onboard/widgets/dot_onboard/dot_onboard_bloc.dart';
import 'package:slc_app/app/modules/onboard/widgets/item_onboard/item_onboard_bloc.dart';
import 'package:slc_app/app/modules/onboard/onboard_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slc_app/app/modules/onboard/onboard_page.dart';

class OnboardModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DotOnboardBloc()),
        Bind((i) => ItemOnboardBloc()),
        Bind((i) => OnboardBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => OnboardPage()),
      ];

  static Inject get to => Inject<OnboardModule>.of();
}
