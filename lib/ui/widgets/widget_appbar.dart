import 'package:cached_network_image/cached_network_image.dart';
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
      centerTitle: false, // Cambiar para que el título esté alineado a la izquierda con la imagen
      leading: Padding(
        padding: const EdgeInsets.all(8.0), // Añadir un pequeño padding alrededor de la imagen
        child: CircleAvatar(
          radius: 24, // Aumentar ligeramente el tamaño para mayor visibilidad
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              filterQuality: FilterQuality.medium,
              memCacheHeight: 500,
              imageUrl: '${ApiGlobalUrl.generalLinkImagen}$imagen',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinear todo el contenido hacia la izquierda
        children: [
          RichText(
            textAlign: TextAlign.left, // Alinear el texto hacia la izquierda
            text: TextSpan(
              text: 'Hola, ',
              style: const TextStyle(
                fontSize: 14,
                color: UsefulColor.colorlettertitle,
                fontFamily: UsefulLabel.letterWalkwayBold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "$business ($topic)",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: UsefulLabel.letterWalkwayBold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Último inicio de sesión: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())}",
            style: const TextStyle(
              color: UsefulColor.colorhintstyletext,
              fontSize: 12,
            ),
          ),
        ],
      ),
      toolbarHeight: 70,
      elevation: 2.0, // Darle un poco más de elevación para un efecto de sombra suave
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.2), // Sombra más suave
      scrolledUnderElevation: 4.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Altura estándar de AppBar
}
