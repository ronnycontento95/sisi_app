import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/widgets/widget_button_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenTermCondition extends StatelessWidget {
  const ScreenTermCondition({Key? key}) : super(key: key);
  static const routePage = CommonLabel.routerScreenTermCondition;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Términos y condiciones de uso",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Image(image: AssetImage("${CommonLabel.assetsImages}term.png")),
                    const Text(
                      "En un mundo cada vez más conectado, la gestión eficiente de dispositivos "
                      "IoT puede ser un reto. ¿Te gustaría tener una herramienta que te permita monitorear y controlar tus dispositivos de forma centralizada? Con {name}, puedes gestionar fácilmente tus dispositivos IoT desde cualquier lugar. {name} te ofrece una solución integral para visualizar el estado, rendimiento y datos de tus dispositivos conectados.\n\n{name} es tu aliado para tomar decisiones informadas en tiempo real, asegurando que tu red de dispositivos funcione de manera eficiente y segura. Perfecto para la gestión de sensores, actuadores y otros dispositivos IoT en proyectos empresariales o industriales.",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    WidgetButtonView(
                      text: 'Términos y condiciones',
                      onTap: () {
                        launchUrl(Uri.parse('http://34.122.67.202/terminos/'),
                            mode: LaunchMode.externalApplication);
                      },
                      color: CommonColor.colorPrimary,
                    ),
                    WidgetButtonView(
                      text: 'Política de privacidad',
                      onTap: () {
                        launchUrl(Uri.parse('http://34.122.67.202/politicas/'),
                            mode: LaunchMode.externalApplication);
                      },
                      color: CommonColor.colorPrimary,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
