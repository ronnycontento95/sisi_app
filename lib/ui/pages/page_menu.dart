import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';
import 'package:sisi_iot_app/ui/widgets/widget_appbar.dart';
import 'package:sisi_iot_app/ui/widgets/widget_button.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';

class PageMenu extends StatelessWidget {
  const PageMenu({Key? key}) : super(key: key);
  static const routePage = Global.routePageMenu;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: Scaffold(
          backgroundColor: ColorsPalette.colorWhite,
          appBar: widgetAppBar(title: "Menu", fontSize: 25),
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
                          WidgetLabelText().labelTextNormal(text: "Versión ", fontSize: 14, colortext: ColorsPalette.colorPrimary),
                          WidgetLabelText().labelTextNormal(text: "2.0.0 ", fontSize: 14, colortext: ColorsPalette.colorPrimary),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetLabelText().labelTextNormal(text: "Copyright ", fontSize: 12, colortext: ColorsPalette.colorPrimary),
                          WidgetLabelText().labelTextNormal(text: "2018. ", fontSize: 12, colortext: ColorsPalette.colorPrimary),
                          WidgetLabelText().labelTextNormal(text: "Sentinel, Sisi Internet of things", fontSize: 12, colortext: ColorsPalette.colorPrimary),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        value: ColorsPalette.colorWhite);
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: ColorsPalette.colorWhite, blurRadius: 3.0, offset: const Offset(0.75, 0.75))
        ],

      ),
      child: Column(
        children: [
          contInformation("infocircle.png", "Perfil", () {
            // Navigator.pushNamed(context, PageAbout.routePage);
          }),
          contInformation("infocircle.png", "Acerca de", () {
            // Navigator.pushNamed(context, PageAbout.routePage);
          }),
          const Divider(),
          GestureDetector(
            onTap: (){
              AlertDialog alert = AlertDialog(
                title: Text("My title"),
                content: Text("This is my message."),
                actions: [
                ],
              );
            },
            child: contInformation("Cerrar secion.png", "Cerrar secion", () {
              // AlertDialog(
              //   content: SingleChildScrollView(
              //     child: ListBody(
              //       children: <Widget>[
              //         Icon(Icons.info_outline),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           const Center(
              //             child: Text(
              //               "¿Está seguro que deseas cerrar la sesión?",
              //               maxLines: 2,
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: ColorsPalette.colorPrimary,
              //                   fontFamily: Global.lettertitle,
              //                   fontSize: 20),
              //             ),
              //           ),
              //         const SizedBox(
              //           height: 10,
              //         ),
              //         Center(
              //           child: Text(
              //             "Cerrando sesión",
              //             maxLines: 3,
              //             textAlign: TextAlign.center,
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.normal,
              //                 color: ColorsPalette.colorPrimary,
              //                 fontFamily: Global.lettersubtitle,
              //                 fontSize: 16),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   actions: <Widget>[
              //     Column(
              //       children: [
              //         WidgetButton(
              //             text: "Si, continuar",
              //             color:  ColorsPalette.colorPrimary,
              //             onTap: () {
              //               Navigator.of(Utils.globalContext.currentContext!).pop();
              //             }),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           WidgetButton(
              //             text: "No, Cancelar",
              //             color: ColorsPalette.colorSecondary,
              //             colorText: ColorsPalette.colorlettertitle,
              //             colorBorder: ColorsPalette.colorlettertitle,
              //             onTap: () {
              //               Navigator.of(Utils.globalContext.currentContext!).pop();
              //             },
              //           ),
              //       ],
              //     ),
              //   ],
              // );

              // WidgetAlertMessage(GlobalLabel.lblSecureSingOff,
              //     title: GlobalLabel.lblSingOffAlert, textCancelar: GlobalLabel.btnNoCancel, textAccept: GlobalLabel.btnYesContinue, activeCancel: true, colorBtnCancel: GlobalColor.colorwhite, () {
              //       providerLogin!.signOff();
              //     }, iconAlert: "exit.png");
            }),
          ),
        ],
      ),
    );
  }

  Widget contInformation(String icon, String text, VoidCallback? callBack,{double? size=25}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          // Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: WidgetLabelText().labelTextNormal(text: text, fontSize: 14, colortext: ColorsPalette.colorlettertitle)),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
  
}
