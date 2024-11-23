import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartStatus extends StatefulWidget {
  const ChartStatus({super.key});

  @override
  State<ChartStatus> createState() => _ChartStatusState();
}

class _ChartStatusState extends State<ChartStatus> {
  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    print('ronny >>> 1');

    if (pvPrincipal.modelosNodosGraficos != null &&
        pvPrincipal.modelosNodosGraficos!.graficosEstado != null &&
        pvPrincipal.modelosNodosGraficos!.graficosEstado!.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: pvPrincipal.modelosNodosGraficos!.graficosEstado!.length,
          itemBuilder: (context, index) {
            final item = pvPrincipal.modelosNodosGraficos!.graficosEstado![index];
            Color valorColor;
            if (item.valor! < 20) {
              valorColor = Colors.orangeAccent;
            } else if (item.valor! > 100) {
              valorColor = Colors.redAccent;
            } else {
              valorColor = CommonColor.colorPrimary;
            }
            return InkWell(
              onTap: () {
                // Acción cuando se toca la tarjeta
              },
              borderRadius: BorderRadius.circular(16), // Efecto de borde redondeado al presionar
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Márgenes externos
                padding: const EdgeInsets.all(16), // Espaciado interno
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4), // Sombra suave para resaltar
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.shade200, // Bordes ligeros para contraste
                  ),
                ),
                child: Row( // Diseño horizontal para mostrar icono y texto
                  children: [
                    // Icono o imagen principal
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: valorColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${item.valor}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Tamaño destacado
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Espacio entre icono y texto
                    // Información textual
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Texto alineado a la izquierda
                        children: [
                          Text(
                            pvPrincipal.capitalize('${item.nombre}'),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Fecha y hora: ${item.fechahora}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Descripción: ${pvPrincipal.capitalize('${item.descripcion}')}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          });
    }

    return const SizedBox.shrink();
  }
}
