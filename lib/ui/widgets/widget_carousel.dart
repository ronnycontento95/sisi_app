import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text.dart';

import '../utils/global_color.dart';

class CarouselSliderNodos extends StatelessWidget {
  const CarouselSliderNodos({
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
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors:[
              Colors.grey[100]!.withOpacity(0.0),
              Colors.black,
            ] ,
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            WidgetText.title(text: title ?? ' ',color: ColorsPalette.colorWhite,),
            WidgetText(text: subtitle ?? ' ',color: ColorsPalette.colorWhite,),
            WidgetText(text: type ?? ' ',color: ColorsPalette.colorWhite,),
            WidgetText(text: "Nivel: $valor %" ?? ' ',color: ColorsPalette.colorWhite,),
          ],
        ),
      ),

    );
  }
}
