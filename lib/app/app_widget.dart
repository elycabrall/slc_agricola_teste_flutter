import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/blocs/resultado/resultado_bloc.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _blocResultado = Modular.get<ResultadoBloc>();





  @override
  void initState() {
    _blocResultado.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: "SLC Agrícola",
      theme: ThemeData(
        fontFamily: 'glacial',
        brightness: Brightness.light,
        primaryColor: Color(0XFF006940),
        scaffoldBackgroundColor: Color(0XFFEFEFEF),
        backgroundColor: Colors.white,
        accentColor: Colors.white,
        dividerColor: Color(0XFFCCCCCC),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
