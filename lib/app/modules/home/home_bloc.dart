import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_bloc.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';

class HomeBloc extends Disposable {
  BehaviorSubject _controller = BehaviorSubject();

  get stream => _controller.stream;
  get add => _controller.add;

  List<ResultadoModel> _grupos = [];

  fetch(num inicio, num fim, {String visao = 'categoria'}) async {
    List<ResultadoModel> resultado = await Modular.get<ResultadoBloc>().find();
    List<ResultadoModel> filtrado = resultado.where((element) {
      return Jiffy(element.periodoInicio, "dd/MM").month >= inicio.toInt() &&
          Jiffy(element.periodoFim, "dd/MM").month <= fim.toInt();
    }).toList();

    if (filtrado.length > 0) {
      _grupos = [];
      if (visao == 'categoria') {
        filtrado.forEach((element) {
          int index = _grupos.indexWhere((e) {
            return e.nome == element.nome;
          });

          if (index >= 0) {
            _grupos[index].planejado =
                _grupos[index].planejado + element.planejado;
            _grupos[index].realizado =
                _grupos[index].realizado + element.realizado;
          } else {
            _grupos.add(element);
          }
        });
        _grupos.sort((a, b) => a.nome.toString().compareTo(b.nome.toString()));
        _controller.value = _grupos;
      }

      if (visao == 'periodo') {
        filtrado.forEach((element) {
          int index = _grupos.indexWhere((e) {
            return e.periodoInicio == element.periodoInicio &&
                e.periodoFim == element.periodoFim;
          });

          if (index >= 0) {
            _grupos[index].planejado =
                _grupos[index].planejado + element.planejado;
            _grupos[index].realizado =
                _grupos[index].realizado + element.realizado;
          } else {
            _grupos.add(element);
          }
        });

        _grupos.sort((a, b) =>
            a.periodoInicio.toString().compareTo(b.periodoInicio.toString()));
        _controller.value = _grupos;
      }
    } else {
      _grupos = [];
      _controller.value = List<ResultadoModel>();
    }
  }

  @override
  void dispose() {
    _grupos = [];
    _controller.value = null;
    _controller.close();
  }
}
