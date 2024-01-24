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

class ScreenMenu extends StatelessWidget {
  ScreenMenu({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenMenu;
  ProviderPrincipal? pvLogin;

  @override
  Widget build(BuildContext context) {
    pvLogin ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
        value: UsefulColor.colorWhite,
        child: Scaffold(
          backgroundColor: UsefulColor.colorWhite,
          appBar: widgetNewAppBar(title: "Menu", fontSize: 25),
          body: SafeArea(
            child: Column(
              children: [
                menuItems(),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetViewLabelText()
                              .labelTextNormal(text: "Versión ", fontSize: 14, colortext: UsefulColor.colorBlack),
                          WidgetViewLabelText()
                              .labelTextNormal(text: "2.0.0 ", fontSize: 14, colortext: UsefulColor.colorBlack),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetViewLabelText()
                              .labelTextNormal(text: "Copyright ", fontSize: 12, colortext: UsefulColor.colorBlack),
                          WidgetViewLabelText()
                              .labelTextNormal(text: "2018. ", fontSize: 12, colortext: UsefulColor.colorBlack),
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

  Widget menuItems() {
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
          BoxShadow(color: UsefulColor.colorWhite, blurRadius: 3.0, offset: Offset(0.75, 0.75))
        ],
      ),
      child: Column(
        children: [
          infoCard(Icons.person, "Perfil", () {
            // Navigator.pushNamed(context, ScreenAbout.routePage);
          }, size: 20),
          infoCard(Icons.compass_calibration, "Acerca de", () {
            // Navigator.pushNamed(context, ScreenAbout.routePage);
          }),
          infoCard(Icons.document_scanner, "Terminos y condiciones", () {
            // Navigator.pushNamed(context, Page)
          }),
          infoCard(Icons.exit_to_app, "Cerrar sesion", () async  {
            GlobalPreference().deleteUser();
            Navigator.of(Useful.globalContext.currentContext!).pushNamedAndRemoveUntil(ScreenLogin.routePage, (Route<dynamic> route) => false);
          }),
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String text, VoidCallback? callBack, {double? size = 25}) {
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
                child: WidgetViewLabelText()
                    .labelTextNormal(text: text, fontSize: 14, colortext: UsefulColor.colorlettertitle)),
            const Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
