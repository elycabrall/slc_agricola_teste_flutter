import 'package:flutter/material.dart';

class AppTextWidget extends StatefulWidget {
  final String label;
  final String hint;
  final Function validator;
  final Function onSaved;
  final bool password;
  final bool multiline;
  final String valorInicial;

  AppTextWidget(this.label, this.hint,
      {this.validator,
      this.onSaved,
      this.password = false,
      this.multiline = false,
      this.valorInicial = ''});

  @override
  _AppTextWidgetState createState() => _AppTextWidgetState();
}

class _AppTextWidgetState extends State<AppTextWidget> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.valorInicial,
      validator: this.widget.validator,
      onSaved: this.widget.onSaved,
      obscureText: this.widget.password ? !passwordVisible : false,
      keyboardType:
          this.widget.multiline ? TextInputType.multiline : TextInputType.text,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: new EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        labelText: this.widget.label,
        labelStyle:
            TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
        hintText: this.widget.hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        suffixIcon: widget.password
            ? IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _toggle();
                },
              )
            : null,
        errorStyle: TextStyle(fontSize: 12),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
      ),
    );
  }
}
