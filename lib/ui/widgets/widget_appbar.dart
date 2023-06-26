import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../data/repositories/api_global_url.dart';
import '../global/global.dart';
import '../global/global_integration.dart';
import '../global/global_palette.dart';
import '../global/utils.dart';
import '../screen/screen_menu.dart';

widgetNewAppBar(
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
    IconData? icon = Icons.arrow_back,
    BoxFit fitIcon = BoxFit.fitHeight}) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontFamily: Global.letterWalkwayBold, color: colortext, fontSize: fontSize, fontWeight: fontWeight),
        textAlign: textAlign,
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
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
      actions: actions);
}

widgetAppBarHome(
  String? image,
  String? business,
) {
  return AppBar(
    leading: image != null
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
                placeholder: GlobalIntegration().getTransparentImage(),
                image: "${ApiGlobalUrl.generalLink}/${image ?? ""}",
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
        style: const TextStyle(fontSize: 14, color: ColorsPalette.colorlettertitle, fontFamily: Global.lettertitle),
        children: <TextSpan>[
          TextSpan(
              text: business ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Global.lettertitle,
                  color: ColorsPalette.colorSecondary,
                  fontSize: 16)),
        ],
      ),
    ),

    actions: [
      GestureDetector(
          onTap: () {
            Navigator.of(Utils.globalContext.currentContext!).pushNamed(ScreenMenu.routePage);
          },
          child: const Icon(Icons.menu_sharp, size: 20, color: ColorsPalette.colorPrimary)),
      const SizedBox(
        width: 20,
      )
    ],
    toolbarHeight: 70,
    elevation: 1.0,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.grey,
    scrolledUnderElevation: 3.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
  );
}
