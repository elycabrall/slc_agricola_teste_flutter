import 'package:flutter/material.dart';

class ButtonLinkWidget extends StatefulWidget {
  final String text;
  final Function callback;
  final Color color;

  ButtonLinkWidget(
    this.text,
    this.callback,
    this.color,
  );

  @override
  _ButtonLinkWidgetState createState() => _ButtonLinkWidgetState();
}

class _ButtonLinkWidgetState extends State<ButtonLinkWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        elevation: 0.0,
        padding: EdgeInsets.all(0),
        color: Colors.transparent,
        onPressed: this.widget.callback,
        child: Text(
          this.widget.text,
          style: TextStyle(
            fontSize: 15,
            color: this.widget.color != null
                ? this.widget.color
                : Color(0XFFF6065E),
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }
}
