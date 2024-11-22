import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartGraficaStatus extends StatelessWidget {
  const ChartGraficaStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    // Control de carga si no hay datos
    if (pvPrincipal.modelosNodosGraficos == null ||
        pvPrincipal.modelosNodosGraficos!.graficosEstado == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Wrap(
        spacing: 16, // Espaciado horizontal entre los elementos
        runSpacing: 16, // Espaciado vertical entre las filas
        alignment: WrapAlignment.center, // Centrar las filas
        children: [
          for (int i = 0; i < pvPrincipal.modelosNodosGraficos!.graficosEstado!.length; i++)
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
                  const SizedBox(height: 10,),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: CommonColor.colorPrimary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${pvPrincipal.modelosNodosGraficos!.graficosEstado![i].valor}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    pvPrincipal.capitalize('${pvPrincipal.modelosNodosGraficos!.graficosEstado![i].nombre}'),
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${pvPrincipal.modelosNodosGraficos!.graficosEstado![i].fechahora}",
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
