import 'package:flutter/material.dart';
import 'package:slc_app/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';


main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(ModularApp(module: AppModule()));
  } catch (error) {
    print(error);
  }
}
