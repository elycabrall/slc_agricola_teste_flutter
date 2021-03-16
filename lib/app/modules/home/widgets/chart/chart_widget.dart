import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:slc_app/app/shared/blocs/resultado/resultado_model.dart';
import 'package:slc_app/app/shared/models/grafico_model.dart';

class ChartWidget extends StatefulWidget {
  final String visao;
  final List<ResultadoModel> dataSet;
  ChartWidget({
    this.visao,
    this.dataSet,
  });
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<GraficoModel> planejado = [];
  List<GraficoModel> realizado = [];

  @override
  void initState() {
    atualizaDados();
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    atualizaDados();
    super.didUpdateWidget(oldWidget);
  }

  atualizaDados() {
    planejado = [];
    realizado = [];
    widget.dataSet.forEach((element) {
      String _id;
      if (widget.visao == 'categoria') {
        _id = element.nome;
      }

      if (widget.visao == 'periodo') {
        _id = element.periodoInicio + ' à ' + element.periodoFim;
      }

      planejado.add(GraficoModel(_id, element.planejado));
      realizado.add(GraficoModel(_id, element.realizado));
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 250,
      padding: EdgeInsets.all(8.0),
      child: charts.BarChart(
        [
          charts.Series<GraficoModel, String>(
            displayName: 'Planejado',
            id: 'Planejado',
            domainFn: (GraficoModel item, _) => item.x,
            measureFn: (GraficoModel item, _) => item.y,
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Color(0xFF006940),
            ),
            data: planejado,
            labelAccessorFn: (GraficoModel item, _) => item.y.toString(),
          ),
          charts.Series<GraficoModel, String>(
            displayName: 'Realizado',
            id: 'Realizado',
            domainFn: (GraficoModel item, _) => item.x,
            measureFn: (GraficoModel item, _) => item.y,
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Color(0xFF909833),
            ),
            data: realizado,
            labelAccessorFn: (GraficoModel item, _) => item.y.toString(),
          ),
        ],
        animate: true,
        vertical: true,
        behaviors: [new charts.SeriesLegend()],
        barRendererDecorator: new charts.BarLabelDecorator<String>(),
        domainAxis: new charts.OrdinalAxisSpec(),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 14,
              color: charts.MaterialPalette.gray.shade800,
            ),
            lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
