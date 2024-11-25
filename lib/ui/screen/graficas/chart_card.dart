import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_graficas.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({super.key, this.controllerScroll});
  final ScrollController? controllerScroll;
  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    if (pvPrincipal.modelosNodosGraficos != null &&
        pvPrincipal.modelosNodosGraficos!.lineData != null &&
        pvPrincipal.modelosNodosGraficos!.lineData!.isNotEmpty) {
      return ListView.builder(
        controller: controllerScroll,
        shrinkWrap: true,
        itemCount: pvPrincipal.modelosNodosGraficos!.lineData!.length,
        itemBuilder: (context, index) {
          final item = pvPrincipal.modelosNodosGraficos!.lineData![index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: ExpansionTile(
              shape: const Border(),
              title: Text(item.titulo!),
              subtitle: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
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
                        '${item.y!.first}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha: ${pvPrincipal.formateDate("${item.x?.first}")}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hora: ${pvPrincipal.formateHours("${item.x?.first}")}',
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
              children: [
                // Tabla que muestra x e y en pares
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2), // Hacer la columna de 'x' más ancha
                      1: FlexColumnWidth(1), // Ancho relativo para 'y'
                      2: FlexColumnWidth(1), // Ancho relativo para 'z'
                    },
                    children: [
                      // Encabezados de la tabla
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fecha',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Hora',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Valor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      // Relleno dinámico de datos
                      ...List.generate(
                        item.x!.length,
                            (i) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                pvPrincipal.formateDate('${item.x![i]}'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                pvPrincipal.formateHours('${item.x![i]}'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${item.y![i]}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }


    return const SizedBox.shrink();
  }
}


class TablaDiccionarioNodo extends StatelessWidget {
  const TablaDiccionarioNodo({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

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
            color: CommonColor.colorPrimary,
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