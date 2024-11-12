import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/main.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenDetailDiccionario extends StatelessWidget {
  static const routePage = UsefulLabel.routerScreenDataDeviceId;

  const ScreenDetailDiccionario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Reportes de Nodos",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomChartLine(),
            TablaDiccionarioNodo(),
          ],
        ),
      ),
    );
  }
}

class CustomChartLine extends StatelessWidget {
  const CustomChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    // Control de carga si no hay datos
    if (pvPrincipal.modelDiccionarioNodo == null ||
        pvPrincipal.modelDiccionarioNodo!.data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Mapea los datos a la lista de SalesData
    final List<SalesData> chartData = pvPrincipal.modelDiccionarioNodo!.data!.map((item) {
      return SalesData(DateTime.fromMillisecondsSinceEpoch(item.idDatos!), // Convierte hora a DateTime
        item.valor!.toDouble(),
      );
    }).toList();

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(),
      title: ChartTitle(text: "Gráfica"),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),

      series: <CartesianSeries>[
        // LineSeries
        LineSeries<SalesData, DateTime>(
          dataSource: chartData,
          dashArray: <double>[5, 5],
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: UsefulColor.colorPrimary,
          markerSettings: const MarkerSettings(
            color: UsefulColor.colorPrimary,
            isVisible: true, // Habilita los marcadores
            shape: DataMarkerType.circle, // Forma del marcador
            width: 5, // Ancho del marcador
            height: 5, // Alto del marcador
          ),
        )
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}

class TablaDiccionarioNodo extends StatelessWidget {
  const TablaDiccionarioNodo({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.modelDiccionarioNodo == null ||
        pvPrincipal.modelDiccionarioNodo!.data == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    int contador = pvPrincipal.modelDiccionarioNodo!.data!.length; // Inicia el contador en 1

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Color del borde
              width: 1.0, // Ancho del borde
            ),
            color: UsefulColor.colorPrimary,
          ),
          columnSpacing: 40,
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => Colors.deepPurpleAccent.withOpacity(0.1),
          ),
          columns: const [
            DataColumn(
              label: Text(
                '#',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                'Alias',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                'Valor',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                'Fecha',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                'Hora',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
          rows: pvPrincipal.modelDiccionarioNodo!.data!.map((item) {
            final fila = DataRow(
              cells: [
                DataCell(Text(contador.toString(), style: const TextStyle(fontSize: 12))),
                DataCell(Text(item.nombreDiccionario ?? "Sin Nombre",
                    style: const TextStyle(fontSize: 12))),
                DataCell(
                    Text(item.valor.toString(), style: const TextStyle(fontSize: 12))),
                DataCell(Text(item.hora!, style: const TextStyle(fontSize: 12))),
                DataCell(Text(DateFormat('yyyy-MM-dd').format(item.fechahora!),
                    style: const TextStyle(fontSize: 12))),
              ],
            );
            contador--;
            return fila;
          }).toList().reversed.toList(),
          dividerThickness: 1,
          dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.white),
          dataRowMaxHeight: 20,
          dataRowMinHeight: 20,
          headingRowHeight: 20,
          // Altura de encabezado más compacta
          headingTextStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
