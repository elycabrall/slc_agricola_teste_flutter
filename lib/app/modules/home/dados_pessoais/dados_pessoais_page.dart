import 'package:flutter/material.dart';

class DadosPessoaisPage extends StatefulWidget {
  final String title;
  const DadosPessoaisPage({Key key, this.title = "DadosPessoais"})
      : super(key: key);

  @override
  _DadosPessoaisPageState createState() => _DadosPessoaisPageState();
}

class _DadosPessoaisPageState extends State<DadosPessoaisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
