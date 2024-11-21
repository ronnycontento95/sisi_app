import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/color.dart';
import '../../provider/provider_principal.dart';

class CustomChartPsi extends StatelessWidget {
  const CustomChartPsi({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    // Control de carga si no hay datos
    if (pvPrincipal.modelosNodosGraficos == null ||
        pvPrincipal.modelosNodosGraficos!.lineData == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Mapea los datos a la lista de SalesData
    final List<SalesData> chartData = pvPrincipal.modelosNodosGraficos!.lineData!
        .where((item) => item.nombre == "psi") // Filtrar por nombre
        .expand((item) => List.generate(item.x!.length,
            (index) => SalesData(DateTime.parse('${item.x![index]}'), item.y![index])))
        .toList();

    return chartData.isNotEmpty
        ? SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.auto,
              dateFormat: DateFormat("dd/MM HH:mm"),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: const TextStyle(
                color: Colors.black, // Color negro para las etiquetas del eje X
              ),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'Presión del agua [PSI]',
                textStyle: const TextStyle(
                  color: Colors.black, // Color negro para el título del eje Y
                ),
              ),
              labelStyle: const TextStyle(
                color: Colors.black, // Color negro para las etiquetas del eje Y
              ),
            ),
            title: ChartTitle(
              text: "Presión del agua",
              textStyle: const TextStyle(
                color: Colors.black, // Color negro para el título del gráfico
              ),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: 'Dato',
              format: 'point.x : point.y',
              textStyle: const TextStyle(
                color: Colors.black, // Color negro para el texto del tooltip
              ),
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              enablePinching: true,
            ),
            series: <CartesianSeries>[
              LineSeries<SalesData, DateTime>(
                dataSource: chartData,
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  textStyle: TextStyle(
                    color: Colors.black, // Color negro para las etiquetas de datos
                  ),
                ),
                color: Colors.blueAccent,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  width: 8,
                  height: 8,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
