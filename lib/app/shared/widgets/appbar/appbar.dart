import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

AppBar appBar(
  String titulo,
  BuildContext context, {
  bool exLeading = true,
  VoidCallback funcReturn,
}) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    leading: exLeading
        ? IconButton(
            icon: Icon(
              MaterialIcons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onPressed: funcReturn == null
                ? () {
                    Modular.to.pop(context);
                  }
                : funcReturn,
          )
        : Container(),
    bottom: PreferredSize(
      child: Container(
        color: Theme.of(context).dividerColor,
        height: 0.5,
      ),
      preferredSize: Size.fromHeight(1.0),
    ),
    centerTitle: true,
    title: Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        titulo.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
    elevation: 0.0,
  );
}
