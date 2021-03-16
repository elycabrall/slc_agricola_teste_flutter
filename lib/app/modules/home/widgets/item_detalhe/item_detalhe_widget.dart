import 'package:flutter/material.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';
import 'package:slc_app/app/shared/widgets/appbar/appbar.dart';

class ItemDetalheWidget extends StatelessWidget {
  final ResultadoModel item;

  const ItemDetalheWidget({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        'DETALHES',
        context,
        exLeading: true,
      ),
      body: ListView(
        children: [
          _linha(context, item.nome, 'Categoria'),
          _linha(context, item.periodoInicio, 'Início'),
          _linha(context, item.periodoFim, 'Fim'),
          _linha(context, item.planejado, 'Planejado'),
          _linha(context, item.realizado, 'Realizado'),
          _linha(context, item.unidadeMedida, 'Unidade de Medida'),
          _linha(context, item.unidadeMedidaSigla, 'Unidade de Medida (Sigla)'),
        ],
      ),
    );
  }

  _linha(context, valor, campo) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                valor.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                campo.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
