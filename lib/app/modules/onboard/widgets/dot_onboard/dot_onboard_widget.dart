import 'package:flutter/material.dart';

class DotOnboardWidget extends StatelessWidget {
  final bool ativo;
  DotOnboardWidget(this.ativo);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      margin: const EdgeInsets.symmetric(horizontal: 3.2),
      height: 8,
      width: ativo ? 25 : 15,
      decoration: BoxDecoration(
        color: ativo
            ? Theme.of(context).accentColor
            : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
