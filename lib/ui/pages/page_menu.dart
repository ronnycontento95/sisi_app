import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';
import 'package:sisi_iot_app/ui/widgets/widget_appbar.dart';
import 'package:sisi_iot_app/ui/widgets/widget_button.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';

class PageMenu extends StatelessWidget {
  PageMenu({Key? key}) : super(key: key);
  static const routePage = Global.routePageMenu;
  ProviderLogin? pvLogin;

  @override
  Widget build(BuildContext context) {
    pvLogin ??= Provider.of<ProviderLogin>(context);
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
        boxShadow: const  <BoxShadow>[
          BoxShadow(
              color: ColorsPalette.colorWhite, blurRadius: 3.0, offset: Offset(0.75, 0.75))
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
              pvLogin!.signOff();
            },
            child: contInformation("Cerrar secion.png", "Cerrar secion", () {
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
