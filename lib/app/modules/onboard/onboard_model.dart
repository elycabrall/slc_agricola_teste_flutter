import 'package:flutter/material.dart';
import 'package:slc_app/app/shared/constants/constants.dart';

class OnBoardModel {
  String imagem;
  String row_1;
  String skipBtn;

  OnBoardModel({
    @required this.imagem,
    @required this.row_1,
    this.skipBtn,
  });
}

final sliderArrayList = [
  OnBoardModel(
    imagem: 'assets/img/ilustracoes/1.png',
    row_1: Constants.SLIDER_HEADING_1_ROW_1,
    skipBtn: Constants.SKIP,
  ),
  OnBoardModel(
    imagem: 'assets/img/ilustracoes/2.png',
    row_1: Constants.SLIDER_HEADING_2_ROW_1,
    skipBtn: Constants.SKIP,
  ),
  OnBoardModel(
    imagem: 'assets/img/ilustracoes/3.png',
    row_1: Constants.SLIDER_HEADING_3_ROW_1,
    skipBtn: "",
  ),
];
