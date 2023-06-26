import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

import '../global/global_palette.dart';


class WidgetViewCarousel extends StatelessWidget {
  const WidgetViewCarousel({
    Key? key,
    this.subtitle,
    this.title,
    this.type,
    this.valor,
    this.image,
    this.btnText,
    this.imageHeight,
    this.imageWidth = 65,
    this.buttonColor = ColorsPalette.colorPrimary,
    this.color = ColorsPalette.colorWhite,
    this.onPressed,
    this.onTap,
  }) : super(key: key);
  final String? subtitle;
  final String? title;
  final String? type;
  final double? valor;
  final String? image;
  final String? btnText;
  final Color? buttonColor;
  final Color? color;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _description()
          ],
        )
    );
  }
  Widget _description(){
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            WidgetTextView.title(text: title ?? ' ',color: ColorsPalette.colorPrimary,),
            WidgetTextView(text: subtitle ?? ' ',color: ColorsPalette.colorPrimary,),
            WidgetTextView(text: type ?? ' ',color: ColorsPalette.colorPrimary,),
            WidgetTextView(text: "Nivel: $valor %" ?? ' ',color: ColorsPalette.colorPrimary,),
          ],
        ),
      ),

    );
  }
}
