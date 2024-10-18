import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'useful_palette.dart';

class TitleStyle extends TextStyle {
  final double size;
  final Color color;

  const TitleStyle({this.size = 16, this.color = UsefulColor.colorlettertitle})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: UsefulLabel.letterWalkwayBold,
  );
}

class NumberBoldStyle extends TextStyle {
  final double size;
  final Color color;

  const NumberBoldStyle({this.size = 12, this.color = UsefulColor.colorlettertitle})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: UsefulLabel.letterWalkwayBold,
  );
}

class SubtitleStyle extends TextStyle {
  final double size;
  final Color color;

  const SubtitleStyle({this.size = 14, this.color = UsefulColor.colorlettertitle})
      : super(
    color: color,
    fontSize: size,
    fontFamily: UsefulLabel.letterWalkwaySemiBold,
  );
}

class NormalStyle extends TextStyle {
  final double size;
  final Color color;

  const NormalStyle({this.size = 12, this.color = UsefulColor.colorlettertitle})
      : super(
    color: color,
    fontSize: size,
    fontFamily: UsefulLabel.letterWalkwayBold,
  );
}
