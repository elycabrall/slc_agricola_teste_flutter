import 'package:flutter/material.dart';

import '../../onboard_model.dart';

class ItemOnboardWidget extends StatelessWidget {
  final int index;
  ItemOnboardWidget(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          sliderArrayList[index].row_1,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 25.0,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                sliderArrayList[index].imagem,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
