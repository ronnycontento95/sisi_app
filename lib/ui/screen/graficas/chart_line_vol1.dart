import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/color.dart';
import '../../provider/provider_principal.dart';

class CustomChartVol1 extends StatelessWidget {
  const CustomChartVol1({super.key});

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
        .where((item) => item.nombre == "vol1") // Filtrar por nombre
        .expand((item) => List.generate(item.x!.length,
            (index) => SalesData(DateTime.parse('${item.x![index]}'), item.y![index])))
        .toList();

    return  chartData.isNotEmpty ?SfCartesianChart(
      title: ChartTitle(
        text: "Volumen de agua",
        textStyle: const TextStyle(
          color: Colors.black, // Título del gráfico
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.auto,
        dateFormat: DateFormat("dd/MM HH:mm"),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),

        labelStyle: const TextStyle(
          color: Colors.black, // Etiquetas del eje X
          fontSize: 10,
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Volumen de agua [m3]',
          textStyle: const TextStyle(
            color: Colors.black, // Título del eje Y
            fontSize: 12,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black, // Etiquetas del eje Y
          fontSize: 10,
        ),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: 'Dato',
        format: 'point.x : point.y',
        textStyle: const TextStyle(
          color: Colors.black, // Tooltip
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
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: const TextStyle(
              color: Colors.black, // Etiquetas de datos
              fontSize: 10,
            ),
          ),
          color: Colors.blueAccent,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            borderColor: Colors.black,
            borderWidth: 1,
            width: 8,
            height: 8,
          ),
        ),
      ],
    ): SizedBox.shrink();

  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
