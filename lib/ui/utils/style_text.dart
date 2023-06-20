import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';

class TitleStyle extends TextStyle {
  final double size;
  final Color color;

  const TitleStyle({this.size = 20, this.color = ColorsPalette.colorlettertitle})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: 'metaprobold',
  );
}

class NumberBoldStyle extends TextStyle {
  final double size;
  final Color color;

  const NumberBoldStyle({this.size = 20, this.color = ColorsPalette.colorlettertitle})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: 'metaheadbold',
  );
}

class SubtitleStyle extends TextStyle {
  final double size;
  final Color color;

  const SubtitleStyle({this.size = 20, this.color = ColorsPalette.colorlettertitle})
      : super(
    color: color,
    // fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: Global.lettersubtitle,
  );
}

class NormalStyle extends TextStyle {
  final double size;
  final Color color;

  const NormalStyle({this.size = 16, this.color = ColorsPalette.colorlettertitle})
      : super(
    color: color,
    fontSize: size,
    fontFamily: 'metaproregular',
  );
}
