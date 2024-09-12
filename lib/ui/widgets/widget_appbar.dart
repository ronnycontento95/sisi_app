import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import '../../data/repositories/api_global_url.dart';
import '../screen/screen_menu.dart';
import '../useful/useful.dart';
import '../useful/useful_palette.dart';

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
    Color colortext = UsefulColor.colorlettertitle,
    IconData? icon = Icons.arrow_back,
    BoxFit fitIcon = BoxFit.fitHeight}) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontFamily: UsefulLabel.letterWalkwayBold,
            color: colortext,
            fontSize: fontSize,
            fontWeight: fontWeight),
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
                    Navigator.of(Useful.globalContext.currentContext!).pop();
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
              bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
      actions: actions);
}


class WidgetAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const WidgetAppBarHome({super.key, this.imagen, this.business, this.topic});
  final String? imagen;
  final String? business;
  final String? topic;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: UsefulColor.colorWhite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FadeInImage.memoryNetwork(
            imageErrorBuilder: (context, _, __) {
              return const Icon(Icons.person);
            },
            placeholderErrorBuilder: (_, __, stackTrace) {
              return const Icon(Icons.person);
            },
            placeholder: UsefulImagen().getTransparentImage(),
            image: "${ApiGlobalUrl.generalLink}$imagen",
            height: 40,
          ),
        ),
      ),
      // :  Icons(Icons.abc),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Hola, ',
              style: const TextStyle(
                  fontSize: 14,
                  color: UsefulColor.colorlettertitle,
                  fontFamily: UsefulLabel.letterWalkwayBold),
              children: <TextSpan>[
                TextSpan(
                    text: "$business ($topic)",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: UsefulLabel.letterWalkwayBold,
                        color: Colors.black,
                        fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Ultimo inicio de sesion: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())}",
            style: const TextStyle(color: UsefulColor.colorhintstyletext, fontSize: 12),
          )
        ],
      ),
      toolbarHeight: 70,
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Altura estándar de AppBar
}
