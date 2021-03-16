import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:slc_app/app/modules/home/widgets/item_detalhe/item_detalhe_widget.dart';
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';

class GridWidget extends StatefulWidget {
  final String visao;
  final List<ResultadoModel> dataSet;
  GridWidget({
    this.visao,
    this.dataSet,
  });
  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(8),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Text(
            'Toque em qualquer linha\npara mais informações',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.visao == 'categoria' ? 'Categoria' : 'Período',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Planejado',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Realizado',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Medida',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemCount: widget.dataSet.length > 0 ? widget.dataSet.length : widget.dataSet.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Container(
                          color: index % 2 == 0
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Colors.transparent,
                          child: retornaLinhaTabela(
                            widget.dataSet.length > 0
                                ? widget.dataSet[index]
                                : widget.dataSet[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget retornaLinhaTabela(ResultadoModel item) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => ItemDetalheWidget(item: item),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.visao == 'categoria'
                    ? item.nome
                    : item.periodoInicio + ' à ' + item.periodoFim,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                item.planejado.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                item.realizado.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                item.unidadeMedida.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
