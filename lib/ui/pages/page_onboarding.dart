import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/pages/page_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/global_label.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';
import 'package:sisi_iot_app/ui/widgets/widget_button.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';

class PageOnboarding extends StatelessWidget {
  const PageOnboarding({Key? key}) : super(key: key);
  static const routePage = Global.routePageOnboarding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image(image: AssetImage("${Global.assetsLogo}logo-estandar.png"), height: 40, width: 200,),
                SizedBox(
                  height: 390,
                  child: PageView(
                    controller: null,
                    children: <Widget>[
                      widgetSlider(context, "Monitoreo remoto",
                          "Sentinel-Iot, una solucion dedicada al monitoreo remoto de tanques reservorios de agua y GLP mediante Internet"),
                      // widgetSlider(
                      //     context,
                      //     "Una solución de movilidad universitaria",
                      //     "Dentro o fuera de la Universidad, elige como te mueves de forma rápida y segura."),
                      // widgetSlider(context, "Movilidad sostenible y ecológica",
                      //     "Fomentamos un sistema de movilidad sostenible y ecológica, amigable con el medio ambiente."),
                    ],
                  ),
                ),
                widgetIndicator(),
                widgetButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetSlider(BuildContext context, String text, String text_1) {
    return Column(
      children: [
        Expanded(child: widgetOnboard()),
        con_text_wid(text),
        const SizedBox(
          height: 10,
        ),
        contTextSubtitle(text_1),
      ],
    );
  }

  Widget contTextSubtitle(String text) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetLabelText().labelTextNormal(
              text: text,
              fontSize: 16,
              textAlign: TextAlign.center,
              colortext: ColorsPalette.colorlettertitle,
              fontWeight: FontWeight.w300,
              maxLines: 4),
        ],
      ),
    );
  }

  Widget widgetOnboard() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Image(image: AssetImage("${Global.assetsImages}onboard.png"),)
    );
  }

  Widget widgetIndicator() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: DotsIndicator(
        decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.grey.shade300,
          activeColor: ColorsPalette.colorPrimary,
        ),
        dotsCount: 3,
        // position:
        // double.parse(_providerConfiguracion!.posicionSlider.toString())
      ),
    );
  }

  Widget con_text_wid(String text) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "!",
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: Global.lettertitle,
                    color: ColorsPalette.colorPrimary200),
                children: <TextSpan>[
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: Global.lettertitle,
                      color: ColorsPalette.colorPrimary,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: Global.lettertitle,
                        color: ColorsPalette.colorPrimary200),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget widgetButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          WidgetButton(
            text: "Ingresar ahora",
            color: ColorsPalette.colorPrimary,
            onTap: () {
              // Navigator.pushNamed(context, PageLogin.routePage);
              Navigator.of(Utils.globalContext.currentContext!).pushNamed(PageLogin.routePage);
            },
          ),
        ],
      ),
    );
  }
}
