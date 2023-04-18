import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

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
      double scrolledUnderElevation= 3.0,
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
      scrolledUnderElevation:scrolledUnderElevation,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
    actions: actions
  );
}
