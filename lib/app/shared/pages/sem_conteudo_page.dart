import 'package:flutter/material.dart';
import 'package:slc_app/app/shared/widgets/appbar/appbar.dart';

class SemConteudoPage extends StatefulWidget {
  final String title;
  final String titulo;
  final String texto;
  final String imagem;
  final bool interno;

  const SemConteudoPage(
      {Key key,
      this.title = "Não encontrado",
      this.interno = false,
      this.imagem = 'assets/img/ilustracoes/1.png',
      this.titulo,
      this.texto})
      : super(key: key);

  @override
  _SemConteudoPageState createState() => _SemConteudoPageState();
}

class _SemConteudoPageState extends State<SemConteudoPage> {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  _body(context) {
    if (widget.interno) {
      return _content(context);
    } else {
      return Scaffold(
        appBar: appBar(widget.title, context),
        body: _content(context),
      );
    }
  }

  _content(context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagem),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.texto,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
