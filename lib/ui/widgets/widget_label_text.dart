import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';

class WidgetLabelText {
  Widget labelTextTitle(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color colortext = ColorsPalette.colorlettertitle}) {
    return AutoSizeText(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: Global.letterWalkwayBold,
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
      Color colortext = ColorsPalette.colorGrey}) {
    return AutoSizeText(
      text,
      maxLines: 2,
      style: TextStyle(
          fontFamily: Global.letterWalkwaySemiBold,
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
      Color colortext = ColorsPalette.colorGrey,
      int maxLines = 2}) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: Global.letterWalkwayBold,
          color: colortext,
          fontSize: fontSize,
          fontWeight: fontWeight),
      textAlign: textAlign,
      minFontSize: 10,
    );
  }

  Widget labelTextLogo(String titulo, double tamanio,
      {FontWeight fontWeight = FontWeight.normal,
      Color colortext = ColorsPalette.colorSecondary}) {
    return Text(titulo,
        style: TextStyle(
            fontFamily: Global.lettertitle,

            color: colortext,
            fontSize: tamanio,
            fontWeight: fontWeight));
  }
}
