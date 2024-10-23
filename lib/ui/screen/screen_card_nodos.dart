import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

class ScreenCardNodos extends StatelessWidget {
  const ScreenCardNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListCardNodos(),
      ),
    );
  }
}

class ListCardNodos extends StatelessWidget {
  const ListCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(pvPrincipal.modelListNodos?.nodos?.length ?? 0, (index) {
        final device = pvPrincipal.modelListNodos?.nodos?[index];
        return SizedBox(
          width: MediaQuery.of(context).size.width, // Usar todo el ancho disponible
          height: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  pvPrincipal.getDataDeviceId(device!.idNodos!, context);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: UsefulColor.colorWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: UsefulColor.colorhintstyletext.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              "${UsefulLabel.assetsImages}wifi.gif",
                              width: 50,
                              height: 50,
                              color: Colors.blue // Color de la imagen
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.device_thermostat_outlined,
                                      color: UsefulColor.colorhintstyletext,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 5),
                                    // Espaciado entre el icono y el texto
                                    Text(
                                      device!.nombrePresentar!,
                                      style: const TextStyle(
                                        color: UsefulColor.colorPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 30,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
