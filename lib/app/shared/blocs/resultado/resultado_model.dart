class ResultadoModel {
  String nome;
  int planejado;
  int realizado;
  String periodoInicio;
  String periodoFim;
  String unidadeMedida;
  String unidadeMedidaSigla;

  ResultadoModel(
      {this.nome,
      this.planejado,
      this.realizado,
      this.periodoInicio,
      this.periodoFim,
      this.unidadeMedida,
      this.unidadeMedidaSigla});

  ResultadoModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    planejado = json['planejado'];
    realizado = json['realizado'];
    periodoInicio = json['periodoInicio'];
    periodoFim = json['periodoFim'];
    unidadeMedida = json['unidadeMedida'];
    unidadeMedidaSigla = json['unidadeMedidaSigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['planejado'] = this.planejado;
    data['realizado'] = this.realizado;
    data['periodoInicio'] = this.periodoInicio;
    data['periodoFim'] = this.periodoFim;
    data['unidadeMedida'] = this.unidadeMedida;
    data['unidadeMedidaSigla'] = this.unidadeMedidaSigla;
    return data;
  }
}
