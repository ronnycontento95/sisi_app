import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

import '../../data/repositories/api_global_url.dart';

widgetAppBar(
    {Key? key,
    required double fontSize,
    required title,
    activeInformation = false,
    FontWeight fontWeight = FontWeight.bold,
    activeArrow = true,
    ValueGetter? onTap,
    List<Widget>? actions,
    double elevation = 1.0,
    double sizeIcon = 24,
    double scrolledUnderElevation = 3.0,
    TextAlign textAlign = TextAlign.start,
    Color colortext = ColorsPalette.colorlettertitle,
    // ImageProvider<Object>? icon,
    IconData? icon = Icons.arrow_back,
    BoxFit fitIcon = BoxFit.fitHeight}) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontFamily: Global.letterWalkwayBold,
            color: colortext,
            fontSize: fontSize,
            fontWeight: fontWeight),
        textAlign: textAlign,
        // st
      ),
      toolbarHeight: 90,
      centerTitle: true,
      automaticallyImplyLeading: activeArrow,
      leadingWidth: activeArrow ? 48 : 0,
      leading: activeArrow
          ? UnconstrainedBox(
              child: InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  } else {
                    Navigator.of(Utils.globalContext.currentContext!).pop();
                  }
                },
                child: Icon(icon),
              ),
            )
          : null,
      elevation: elevation,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      scrolledUnderElevation: scrolledUnderElevation,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      actions: actions);
}

WidgetAppbarHome(
  String imagen_empresa,
  String nombre_empresa,
) {
  return AppBar(
    leading: imagen_empresa != null
        ? CircleAvatar(
            radius: 20,
            backgroundColor: ColorsPalette.colorWhite,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage.memoryNetwork(
                imageErrorBuilder: (context, _, __) {
                  return const Icon(Icons.person);
                },
                placeholderErrorBuilder: (_, __, stackTrace) {
                  return const Icon(Icons.person);
                },
                placeholder: kTransparentImage,
                image:
                    "${ApiGlobalUrl.generalLink}/${imagen_empresa ?? ""}",
                height: 40,
              ),
            ),
          )
        : const SizedBox(),
    // you can put Icon as well, it accepts any widget.
    title: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Hola, ',
        style: const TextStyle(
            fontSize: 24,
            color: ColorsPalette.colorlettertitle,
            fontFamily: Global.lettertitle),
        children: <TextSpan>[
          TextSpan(
              text: nombre_empresa ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Global.lettertitle,
                  color: ColorsPalette.colorSecondary,
                  fontSize: 24)),
        ],
      ),
    ),

    actions: [
      GestureDetector(
          onTap: () {
            Navigator.of(Utils.globalContext.currentContext!)
                .pushNamed(PageMenu.routePage);
          },
          child: Icon(Icons.menu_sharp,
              size: 20, color: ColorsPalette.colorPrimary)),
      const SizedBox(
        width: 20,
      )
    ],
    toolbarHeight: 90,
    elevation: 1.0,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.grey,
    scrolledUnderElevation: 3.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
  );
}

Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
