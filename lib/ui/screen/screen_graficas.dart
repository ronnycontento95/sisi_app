import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/widgets/widget_custom_sliding_segment.dart';
import 'graficas/chart_line.dart';
import 'graficas/chart_status.dart';
import 'graficas/chart_foco.dart';

ScrollController controllerScroll = ScrollController();

class ScreenGraphics extends StatelessWidget {
  const ScreenGraphics({super.key});

  static const routePage = CommonLabel.routerScreenGraphins;

  @override
  Widget build(BuildContext context) {
    final pvPrincipalRead = context.watch<ProviderPrincipal>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          pvPrincipalRead.modelosNodosGraficos?.nodoIndividual?.nombre_nodo ?? "Graficas",
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5),
        ),
        elevation: 2, // Añade profundidad
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black), // Color de iconos de AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          controller: controllerScroll,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Example6(),
              ],
            ),
            if (pvPrincipalRead.selectPosition == 1) ...[
              const ChartStatus(),
              const ChartFocoGrafica(),
            ] else ...[
              ChartLine(controllerScroll: controllerScroll),
            ]
          ],
        ),
      ),
    );
  }
}

class ChartLine extends StatelessWidget {
  const ChartLine({super.key, this.controllerScroll});

  final ScrollController? controllerScroll;

  @override
  Widget build(BuildContext context) {
    final pvPrincipalRead = context.watch<ProviderPrincipal>();
    if (pvPrincipalRead.modelosNodosGraficos != null &&
        pvPrincipalRead.modelosNodosGraficos!.lineData != null &&
        pvPrincipalRead.modelosNodosGraficos!.lineData!.isNotEmpty) {
      return ListView.builder(
        controller: controllerScroll,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pvPrincipalRead.modelosNodosGraficos!.lineData!.length,
        itemBuilder: (context, index) {
          final item = pvPrincipalRead.modelosNodosGraficos!.lineData![index];
          return CustomChartLineWp(
            topic: item.nombre,
            titulo: item.titulo,
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
