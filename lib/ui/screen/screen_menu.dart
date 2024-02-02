import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/ui/screen/screen_login.dart';

import '../provider/provider_principal.dart';
import '../useful/useful.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';
import '../widgets/widget_appbar.dart';
import '../widgets/widget_label_text.dart';

class ScreenMenu extends StatefulWidget {
  ScreenMenu({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenMenu;

  @override
  State<ScreenMenu> createState() => _ScreenMenuState();
}

class _ScreenMenuState extends State<ScreenMenu> {
  @override
  void initState() {
    super.initState();
    context.read<ProviderPrincipal>().addVersionApp();
  }

  @override
  Widget build(BuildContext context) {
    final prPrincipalWatch = context.watch<ProviderPrincipal>();
    return AnnotatedRegion(
        value: UsefulColor.colorWhite,
        child: Scaffold(
          backgroundColor: UsefulColor.colorWhite,
          appBar: widgetNewAppBar(title: "Menu", fontSize: 25),
          body: SafeArea(
            child: Column(
              children: [
                const MenuItems(),
                Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetViewLabelText().labelTextNormal(
                              text: "Versión ",
                              fontSize: 14,
                              colortext: UsefulColor.colorBlack),
                          WidgetViewLabelText().labelTextNormal(
                              text: "${prPrincipalWatch.version} ",
                              fontSize: 14,
                              colortext: UsefulColor.colorBlack),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetViewLabelText().labelTextNormal(
                              text: "Copyright ",
                              fontSize: 12,
                              colortext: UsefulColor.colorBlack),
                          WidgetViewLabelText().labelTextNormal(
                              text: "2018. ",
                              fontSize: 12,
                              colortext: UsefulColor.colorBlack),
                          WidgetViewLabelText().labelTextNormal(
                              text: "Sentinel, Sisi Internet of things",
                              fontSize: 16,
                              colortext: UsefulColor.colorPrimary),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: UsefulColor.colorPrimary.withOpacity(0.1),
          style: BorderStyle.solid,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: UsefulColor.colorWhite,
              blurRadius: 3.0,
              offset: Offset(0.75, 0.75))
        ],
      ),
      child: Column(
        children: [
          infoCard(Icons.person, "Perfil", () {}, size: 20),
          infoCard(Icons.compass_calibration, "Acerca de", () {}),
          infoCard(Icons.document_scanner, "Terminos y condiciones", () {}),
          infoCard(Icons.exit_to_app, "Cerrar sesion", () async {
            prPrincipalRead.logoOut();
          }),
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String text, VoidCallback? callBack,
      {double? size = 25}) {
    return GestureDetector(
      onTap: () {
        callBack!();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: WidgetViewLabelText().labelTextNormal(
                    text: text,
                    fontSize: 14,
                    colortext: UsefulColor.colorlettertitle)),
            const Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
