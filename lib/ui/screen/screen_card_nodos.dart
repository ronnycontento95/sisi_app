import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

class ScreenCardNodos extends StatelessWidget {
  const ScreenCardNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const TitleCardNodos();
                }, childCount: 1),
              ),
              const ListCardNodos()
            ],
          ),
        ),
      ),
    );
  }
}

class TitleCardNodos extends StatelessWidget {
  const TitleCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${context.read<ProviderPrincipal>().companyResponse.nombre_empresa} nodos",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const Icon(Icons.search)
        ],
      ),
    );
  }
}

class ListCardNodos extends StatelessWidget {
  const ListCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.modelListNodos?.nodos == null ||
        pvPrincipal.modelListNodos!.nodos!.isEmpty) {
      return const Center(
        child: Text("No hay datos disponibles."),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 5,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final itemNodo = pvPrincipal.modelListNodos!.nodos![index];
        return InkWell(
          onTap: (){
            pvPrincipal.getDataDeviceId(itemNodo.idNodos!, context);
          },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 6,
              shadowColor: Colors.black26,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE1BEE7), Color(0xFF9575CD)], // Degradado morado suave
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icono a la izquierda
                      Icon(
                        Icons.device_hub,
                        color: Colors.purple[700],
                        size: 40,
                      ),
                      const SizedBox(width: 12),

                      // Texto en el centro
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemNodo.nombrePresentar ?? "Sin nombre",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              itemNodo.nombre ?? "Sin nombre de presentación",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                      // Fecha a la derecha
                      // Text(
                      //   itemNodo!.fecha ?? "00/00/0000",
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.white60,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
        );
      }, childCount: pvPrincipal.modelListNodos!.nodos!.length),
    );
  }
}
