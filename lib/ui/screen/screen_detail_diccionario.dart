import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/main.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

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
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TablaDiccionarioNodo(),
            ),
          ],
        ),
      ),
    );
  }
}

class TablaDiccionarioNodo extends StatelessWidget {
  const TablaDiccionarioNodo({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    // Muestra un indicador de carga si no hay datos
    if (pvPrincipal.modelDiccionarioNodo == null ||
        pvPrincipal.modelDiccionarioNodo!.data == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    int contador = 1; // Inicia el contador en 1

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          decoration:  BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Color del borde
              width: 1.0,         // Ancho del borde
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
                DataCell(Text(contador.toString(), style: const TextStyle(fontSize: 12))), // Contador de filas
                DataCell(Text(item.nombreDiccionario ?? "Sin Nombre", style: const TextStyle(fontSize: 12))),
                DataCell(Text(item.valor.toString(), style: const TextStyle(fontSize: 12))),
                DataCell(Text(item.hora!, style: const TextStyle(fontSize: 12))),
                DataCell(Text(DateFormat('yyyy-MM-dd').format(item.fechahora!), style: const TextStyle(fontSize: 12))),
              ],
            );
            contador++;
            return fila;
          }).toList(),
          dividerThickness: 1,
          dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.white),
          dataRowMaxHeight: 20,
          dataRowMinHeight: 20,
          headingRowHeight: 20, // Altura de encabezado más compacta
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
