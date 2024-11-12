import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'color.dart';

class TitleStyle extends TextStyle {
  final double size;
  final Color color;

  const TitleStyle({this.size = 16, this.color = CommonColor.colorPrimary})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: CommonLabel.letterWalkwayBold,
  );
}

class NumberBoldStyle extends TextStyle {
  final double size;
  final Color color;

  const NumberBoldStyle({this.size = 12, this.color = CommonColor.colorPrimary})
      : super(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: CommonLabel.letterWalkwayBold,
  );
}

class SubtitleStyle extends TextStyle {
  final double size;
  final Color color;

  const SubtitleStyle({this.size = 14, this.color = CommonColor.colorPrimary})
      : super(
    color: color,
    fontSize: size,
    fontFamily: CommonLabel.letterWalkwaySemiBold,
  );
}

class NormalStyle extends TextStyle {
  final double size;
  final Color color;

  const NormalStyle({this.size = 12, this.color = CommonColor.colorPrimary})
      : super(
    color: color,
    fontSize: size,
    fontFamily: CommonLabel.letterWalkwayBold,
  );
}
