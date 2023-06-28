import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';

import '../useful/useful.dart';
import '../useful/useful_palette.dart';
import '../widgets/widget_button_view.dart';
import '../widgets/widget_label_text.dart';
import 'screen_login.dart';

class ScreenOnBoarding extends StatelessWidget {
  const ScreenOnBoarding({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenOnBoarding;

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
                const Image(image: AssetImage("${UsefulLabel.assetsLogo}logo-estandar.png"), height: 40, width: 200,),
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
          WidgetViewLabelText().labelTextNormal(
              text: text,
              fontSize: 16,
              textAlign: TextAlign.center,
              colortext: UsefulColor.colorlettertitle,
              fontWeight: FontWeight.w300,
              maxLines: 4),
        ],
      ),
    );
  }

  Widget widgetOnboard() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Image(image: AssetImage("${UsefulLabel.assetsImages}onboard.png"),)
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
          activeColor: UsefulColor.colorPrimary,
        ),
        dotsCount: 3,
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
                    fontFamily: UsefulLabel.lettertitle,
                    color: UsefulColor.colorPrimary200),
                children: <TextSpan>[
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: UsefulLabel.lettertitle,
                      color: UsefulColor.colorPrimary,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: UsefulLabel.lettertitle,
                        color: UsefulColor.colorPrimary200),
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
          WidgetButtonView(
            text: "Ingresar ahora",
            color: UsefulColor.colorPrimary,
            onTap: () {
              // Navigator.pushNamed(context, ScreenLogin.routePage);
              Navigator.of(Useful.globalContext.currentContext!).pushNamed(ScreenLogin.routePage);
            },
          ),
        ],
      ),
    );
  }
}
