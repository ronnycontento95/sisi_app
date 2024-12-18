import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/color.dart';

import 'package:sisi_iot_app/ui/common/common_label.dart';

class WidgetButtonView extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final Function? onTap;
  final Color colorText;
  final Color colorBorder;
  final double sizeText;

  const WidgetButtonView(
      {Key? key,
      required this.text,
      required this.color,
      required this.onTap,
      this.colorText = Colors.white,
      this.colorBorder = Colors.transparent,
      this.sizeText = 18,
      this.icon = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color,
              foregroundColor: color,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: CommonColor.colorPrimary, width: 1),
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: onTap == null ? null : () => onTap!(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.percent),
              Text(text,  style: const TextStyle(
                  fontFamily: CommonLabel.letterWalkwaySemiBold,
                  color: Colors.white, fontSize: 16),)
            ],
          )),
    );
  }
}
