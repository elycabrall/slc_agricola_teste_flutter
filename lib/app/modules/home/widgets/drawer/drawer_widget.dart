import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info/package_info.dart';
import 'package:slc_app/app/shared/utils/functions.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String versao;

  @override
  void initState() {
    versao = 'buscando';

    carregaVersao();
    super.initState();
  }

  carregaVersao() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      versao = (packageInfo.version + ' (' + packageInfo.buildNumber + ')')
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 50,
                right: 50,
                top: 70,
                bottom: 45,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        "https://media-exp1.licdn.com/dms/image/C4E03AQFNWeest7hCWw/profile-displayphoto-shrink_800_800/0/1604973605756?e=1621468800&v=beta&t=FaJPE_JBfUoIFBIfojm38p74QZzzmeGa52W1msg2q1Y",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pegaSaudacao(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Ely Cabral!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'elyjrcabral@gmail.com',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        _itemMenu(
                          context,
                          'Dados Pessoais',
                          () {
                            Modular.to.pushNamed('/menu/dados-pessoais');
                          },
                        ),
                        _itemMenu(
                          context,
                          'Fale Conosco',
                          () {
                            Modular.to.pushNamed('/menu/fale-conosco');
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ('Versão ' + versao.toString()).toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Orgulhosamente desenvolvido\npor Ely Cabral',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _itemMenu(context, text, callback) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        dense: true,
        onTap: callback,
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
