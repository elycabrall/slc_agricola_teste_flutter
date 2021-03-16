import 'package:flutter/material.dart';
import 'package:slc_app/app/shared/app_text/app_text.dart';
import 'package:slc_app/app/shared/utils/functions.dart';
import 'package:slc_app/app/shared/widgets/appbar/appbar.dart';
import 'package:slc_app/app/shared/widgets/button_border/button_border_widget.dart';

import 'fale_conosco_model.dart';

class FaleConoscoPage extends StatefulWidget {
  final String title;
  const FaleConoscoPage({Key key, this.title = "FaleConosco"})
      : super(key: key);

  @override
  _FaleConoscoPageState createState() => _FaleConoscoPageState();
}

class _FaleConoscoPageState extends State<FaleConoscoPage> {
  final _formKey = GlobalKey<FormState>();
  final _input = FaleConoscoModel();

  bool enviando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.title, context),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 15,
            ),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/images/ilustracoes/3.png'),
              ),
            ),
          ),
          Text(
            'Precisou de algo?\nEstamos aqui!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  AppTextWidget(
                    "Nome",
                    "Digite seu Nome",
                    password: false,
                    validator: (text) {
                      return validateRequired(text, "Digite seu nome");
                    },
                    onSaved: (value) => this._input.name = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextWidget(
                    "Telefone",
                    "Digite seu Telefone",
                    password: false,
                    validator: (text) {
                      return validateRequired(text, "Digite seu telefone");
                    },
                    onSaved: (value) => this._input.phone = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextWidget(
                    "Email",
                    "Digite seu Email",
                    password: false,
                    validator: (text) {
                      return validateRequired(text, "Digite seu email");
                    },
                    onSaved: (value) => this._input.email = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextWidget(
                    "Mensagem",
                    "Digite sua Mensagem",
                    password: false,
                    validator: (text) {
                      return validateRequired(text, "Digite sua mensagem");
                    },
                    onSaved: (value) => this._input.message = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonBorderWidget(
                    'Enviar',
                    () {
                      setState(() {
                        enviando = true;
                      });

                      Future.delayed(Duration(seconds: 3), () {
                        enviando = false;
                      });
                    },
                    showProgress: enviando,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
