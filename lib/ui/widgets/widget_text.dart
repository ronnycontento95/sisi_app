import 'package:flutter/material.dart';

import '../utils/global_palette.dart';
import '../utils/style_text.dart';

class WidgetText extends StatelessWidget {
  WidgetText(
      {required this.text,
        this.size = 14,
        this.color = ColorsPalette.colorPrimary,
        Key? key, this.maxLines})
      : textStyle = NormalStyle(size: size, color: color),
        super(key: key);

  WidgetText.title(
      {required this.text,
      this.size = 20,
      this.color = ColorsPalette.colorPrimary,
      Key? key, this.maxLines})
      : textStyle = TitleStyle(size: size, color: color),
        super(key: key);

  WidgetText.subTitle(
      {required this.text,
      this.size = 14,
      this.color = ColorsPalette.colorGrey,
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
