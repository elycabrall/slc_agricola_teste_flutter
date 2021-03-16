import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slc_app/app/modules/home/home_bloc.dart';
import 'package:slc_app/app/modules/home/widgets/drawer/drawer_widget.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_bloc.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';
import 'package:slc_app/app/shared/pages/sem_conteudo_page.dart';
import 'package:slc_app/app/shared/utils/prefs.dart';

import 'widgets/chart/chart_widget.dart';
import 'widgets/grid/grid_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _bloc = Modular.get<HomeBloc>();

  String ultimaAtualizacao = '';
  String visao = 'categoria';

  num ini = 1;
  num fim = 3;

  bool reload = false;

  RangeValues _currentRangeValues;

  @override
  void initState() {
    getUltimaAtualizacao();

    _currentRangeValues = RangeValues(
      ini.toDouble(),
      fim.toDouble(),
    );

    _bloc.fetch(
      ini,
      fim,
    );
    super.initState();
  }

  getUltimaAtualizacao() async {
    String ultima = await Prefs.getString('ULTIMA_ATUALIZACAO');
    String data = ultima.substring(6, 8) +
        '/' +
        ultima.substring(4, 6) +
        '/' +
        ultima.substring(0, 4);

    setState(() {
      ultimaAtualizacao = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.only(top: 15, right: 35),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/logo.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 90),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ultimaAtualizacao,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'última atualização',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: !reload
                            ? Icon(Icons.refresh)
                            : CupertinoActivityIndicator(
                                animating: true,
                              ),
                        onPressed: () async {
                          setState(() {
                            reload = true;
                          });
                          bool atualizou = await Modular.get<ResultadoBloc>()
                              .fetch(reset: true);
                          getUltimaAtualizacao();
                          setState(() {
                            reload = false;
                          });

                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(atualizou
                                  ? 'Os dados foram atualizados'
                                  : 'Verifique sua conexão com a internet'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Selecione o período que deseja\nanalisar, por mês',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 1,
                  max: 12,
                  divisions: 12,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey[200],
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      ini = values.start.round();
                      fim = values.end.round();
                      _bloc.fetch(
                        ini,
                        fim,
                        visao: visao,
                      );
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            color: visao == 'categoria'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                              side: BorderSide(
                                width: 0.5,
                                color: visao == 'categoria'
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                              ),
                            ),
                            child: Text(
                              'Categoria',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: visao == 'categoria'
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              if (visao == 'categoria') return;
                              setState(() {
                                visao = 'categoria';
                              });

                              _bloc.fetch(
                                ini,
                                fim,
                                visao: visao,
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            color: visao == 'periodo'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              side: BorderSide(
                                width: 0.5,
                                color: visao == 'periodo'
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                              ),
                            ),
                            child: Text(
                              'Período',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: visao == 'periodo'
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              if (visao == 'periodo') return;
                              setState(() {
                                visao = 'periodo';
                              });

                              _bloc.fetch(
                                ini,
                                fim,
                                visao: visao,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: _bloc.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          animating: true,
                        ),
                      );
                    }

                    List<ResultadoModel> dataSet = snapshot.data;

                    if (dataSet != null && dataSet.length > 0) {
                      return Column(
                        children: [
                          ChartWidget(visao: visao, dataSet: dataSet),
                          SizedBox(
                            height: 15,
                          ),
                          GridWidget(visao: visao, dataSet: dataSet),
                        ],
                      );
                    }

                    return SemConteudoPage(
                      titulo: "Ainda não há nada por aqui :(",
                      texto: "verifique o filtro da sua pesquisa",
                      interno: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
