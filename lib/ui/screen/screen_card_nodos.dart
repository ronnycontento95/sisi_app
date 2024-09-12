import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_web_device.dart';
import 'package:sisi_iot_app/ui/useful/useful.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_dotted_dashed_line.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

class ScreenCardNodos extends StatelessWidget {
  const ScreenCardNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: ListCardNodos(),
    ));
  }
}

class ListCardNodos extends StatelessWidget {
  const ListCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return SizedBox(
      height: 175,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 5, // Espacio entre columnas
          mainAxisSpacing: 5, // Espacio entre filas
          childAspectRatio: 3 / 2.5, // Proporción de ancho/alto de cada item
        ),
        itemCount: pvPrincipal.listFilterDevice!.length, // Tu lista de dispositivos
        itemBuilder: (context, index) {
          final device = pvPrincipal
              .listFilterDevice![index]; // Obteniendo cada dispositivo de la lista

          return GestureDetector(
            onTap: () {
              pvPrincipal.idWebDevice = device.ide!;
              Navigator.of(Useful.globalContext.currentContext!).pushNamed(
                ScreenWebView.routePage,
                arguments: device.ide, // Pasar el valor como argumento
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: UsefulColor.colorPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  device.nombre!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                  text: "Nivel:",
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Text(
                                  "${device.valor!}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                  text: "Hora:",
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Text(
                                  pvPrincipal!.extractTime(device.fechahora!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                    text: "Fecha:", size: 14, color: Colors.white),
                                const Spacer(),
                                Text(
                                  pvPrincipal!.extractDate(device.fechahora!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
