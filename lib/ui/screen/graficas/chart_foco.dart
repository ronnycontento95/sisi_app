import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/widgets/widget_emply.dart';

class ChartFocoGrafica extends StatelessWidget {
  const ChartFocoGrafica({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.modelosNodosGraficos?.focoGrafica == [] ||
        pvPrincipal.modelosNodosGraficos!.focoGrafica!.isEmpty) {
      return const WidgetEmpty();
    }
    return SingleChildScrollView(
      child: Wrap(
        spacing: 16, // Espaciado horizontal entre los elementos
        runSpacing: 16, // Espaciado vertical entre las filas
        alignment: WrapAlignment.center, // Centrar las filas
        children: [
          for (int i = 0; i < pvPrincipal.modelosNodosGraficos!.focoGrafica!.length; i++)
            Container(
              width: MediaQuery.of(context).size.width / 2.5, // Tamaño de cada tarjeta
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2), // Sombra para la tarjeta
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color:
                          pvPrincipal.modelosNodosGraficos!.focoGrafica![i].valor == 0.0
                              ? Colors.green
                              : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.info,
                        color:
                            pvPrincipal.modelosNodosGraficos!.focoGrafica![i].valor == 0.0
                                ? Colors.green
                                : Colors.red,
                      ),
                      // child: Text(,
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pvPrincipal.capitalize(
                        "${pvPrincipal.modelosNodosGraficos!.focoGrafica![i].alias}"),
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${pvPrincipal.modelosNodosGraficos!.focoGrafica![i].fechahora}",
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
