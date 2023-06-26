import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../global/global_palette.dart';
import '../provider/provider_principal.dart';
import '../widgets/widget_appbar.dart';
import '../widgets/widget_label_text.dart';

class ScreenMenu extends StatelessWidget {
  ScreenMenu({Key? key}) : super(key: key);
  static const routePage = Global.routeScreenMenu;
  ProviderPrincipal? pvLogin;

  @override
  Widget build(BuildContext context) {
    pvLogin ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
        value: ColorsPalette.colorWhite,
        child: Scaffold(
          backgroundColor: ColorsPalette.colorWhite,
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
                              .labelTextNormal(text: "Versión ", fontSize: 14, colortext: ColorsPalette.colorPrimary),
                          WidgetViewLabelText()
                              .labelTextNormal(text: "2.0.0 ", fontSize: 14, colortext: ColorsPalette.colorPrimary),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetViewLabelText()
                              .labelTextNormal(text: "Copyright ", fontSize: 12, colortext: ColorsPalette.colorPrimary),
                          WidgetViewLabelText()
                              .labelTextNormal(text: "2018. ", fontSize: 12, colortext: ColorsPalette.colorPrimary),
                          WidgetViewLabelText().labelTextNormal(
                              text: "Sentinel, Sisi Internet of things",
                              fontSize: 12,
                              colortext: ColorsPalette.colorPrimary),
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
          color: ColorsPalette.colorPrimary.withOpacity(0.1),
          style: BorderStyle.solid,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: ColorsPalette.colorWhite, blurRadius: 3.0, offset: Offset(0.75, 0.75))
        ],
      ),
      child: Column(
        children: [
          contInformation(Icons.person, "Perfil", () {
            // Navigator.pushNamed(context, ScreenAbout.routePage);
          }, size: 20),
          contInformation(Icons.compass_calibration, "Acerca de", () {
            // Navigator.pushNamed(context, ScreenAbout.routePage);
          }),
          contInformation(Icons.document_scanner, "Terminos y condiciones", () {
            // Navigator.pushNamed(context, Page)
          }),
          contInformation(Icons.exit_to_app, "Cerrar secion", () {
            pvLogin!.signOff();
          }),
        ],
      ),
    );
  }

  Widget contInformation(IconData icon, String text, VoidCallback? callBack, {double? size = 25}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: WidgetViewLabelText()
                  .labelTextNormal(text: text, fontSize: 14, colortext: ColorsPalette.colorlettertitle)),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
