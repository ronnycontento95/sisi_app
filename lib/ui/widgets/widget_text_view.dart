import 'package:flutter/material.dart';
import '../useful/useful_palette.dart';
import '../useful/useful_style_text.dart';

class WidgetTextView extends StatelessWidget {
  WidgetTextView(
      {required this.text,
        this.size = 14,
        this.color = UsefulColor.colorPrimary,
        Key? key, this.maxLines})
      : textStyle = NormalStyle(size: size, color: color),
        super(key: key);

  WidgetTextView.title(
      {required this.text,
      this.size = 20,
      this.color = UsefulColor.colorPrimary,
      Key? key, this.maxLines})
      : textStyle = TitleStyle(size: size, color: color),
        super(key: key);

  WidgetTextView.subTitle(
      {required this.text,
      this.size = 14,
      this.color = UsefulColor.colorGrey,
      Key? key, this.maxLines})
      : textStyle = SubtitleStyle(size: size, color: color),
        super(key: key);

  final String text;
  final TextStyle textStyle;
  final double size;
  final Color color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}
