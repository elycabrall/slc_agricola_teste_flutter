import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';
import 'package:slc_app/app/shared/utils/prefs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class ResultadoBloc extends Disposable {
  Future<Database> database;

  _openDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'db_slc.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE resultado(id INTEGER PRIMARY KEY, nome TEXT, planejado INTEGER, realizado INTEGER, periodoInicio TEXT, periodoFim TEXT, unidadeMedida TEXT, unidadeMedidaSigla TEXT)",
        );
      },
      version: 1,
    );
  }

  _deleteDB() async {
    await databaseFactory.deleteDatabase('db_slc.db');
  }

  _insertResult(item) async {
    final Database db = await database;

    await db.insert(
      'resultado',
      item,
    );
  }

  fetch({bool reset = false}) async {
    await _openDB();
    String att = await Prefs.getString('ULTIMA_ATUALIZACAO');
    String moment = Jiffy().format("yyyyMMdd");

    if (reset || (att == null || att != moment)) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');

          var url =
              "https://agappprdstorage.blob.core.windows.net/desafioxamarin/requestdesafio.json";

          var response = await http.get(
            url,
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
            List list = json
                .decode(response.body
                        .toString()
                        .trim()
                        .substring(0, response.body.length - 3) +
                    ']')
                .toList();

            await _deleteDB();
            await _openDB();
            list.forEach((element) async {
              await _insertResult(element);
            });

            Prefs.setString('ULTIMA_ATUALIZACAO', moment);

            return true;
          }
        }
      } on SocketException catch (_) {
        return false;
      }
    }
  }

  find() async {
    final Database db = await database;
    final List doc = await db.query('resultado');

    List<ResultadoModel> itens = doc
        .map<ResultadoModel>((json) => ResultadoModel.fromJson(json))
        .toList();
    return itens;
  }

  @override
  void dispose() {}
}
