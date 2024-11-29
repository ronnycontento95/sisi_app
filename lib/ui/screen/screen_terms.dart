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
                      "En un mundo cada vez más interconectado, la gestión eficiente de dispositivos IoT (Internet de las Cosas) puede presentar varios desafíos. Sentinel IoT está diseñado para ofrecerte una solución integral que te permite monitorear y controlar todos tus dispositivos IoT desde una única plataforma, accesible desde cualquier lugar y en cualquier momento.\n"
                      "Sentinel IoT te proporciona herramientas avanzadas para gestionar el estado, rendimiento y datos de tus dispositivos conectados de forma centralizada. Ya sea para la supervisión de sensores, actuadores u otros dispositivos IoT, nuestra plataforma te ofrece la flexibilidad y control necesarios para optimizar tus operaciones en entornos empresariales o industriales.\n"
                      "Con Sentinel IoT, tendrás acceso a información en tiempo real que te permitirá tomar decisiones informadas y garantizar la eficiencia, seguridad y confiabilidad de tu red de dispositivos. Nuestra solución está diseñada para simplificar la gestión de dispositivos IoT, promoviendo la productividad y la toma de decisiones estratégicas en cualquier proyecto relacionado con la tecnología IoT.",
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
