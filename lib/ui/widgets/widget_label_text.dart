import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';


class WidgetViewLabelText {
  Widget labelTextTitle(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color colortext = UsefulColor.colorlettertitle}) {
    return AutoSizeText(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: UsefulLabel.letterWalkwayBold,
          color: colortext,
          fontSize: fontSize,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  Widget labelTextSubtitle(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color colortext = UsefulColor.colorGrey}) {
    return AutoSizeText(
      text,
      maxLines: 2,
      style: TextStyle(
          fontFamily: UsefulLabel.letterWalkwaySemiBold,
          color: colortext,
          fontSize: fontSize,
          fontWeight: fontWeight),
      textAlign: textAlign,
      minFontSize: 10,
    );
  }

  Widget labelTextNormal(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start,
      Color colortext = UsefulColor.colorGrey,
      int maxLines = 2}) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: UsefulLabel.letterWalkwayBold,
          color: colortext,
          fontSize: fontSize,
          fontWeight: fontWeight),
      textAlign: textAlign,
      minFontSize: 10,
    );
  }

  Widget labelTextLogo(String titulo, double tamanio,
      {FontWeight fontWeight = FontWeight.normal,
      Color colortext = UsefulColor.colorSecondary}) {
    return Text(titulo,
        style: TextStyle(
            fontFamily: UsefulLabel.letterWalkwayBold,
            color: colortext,
            fontSize: tamanio,
            fontWeight: fontWeight));
  }
}
