import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/main.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';

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
          headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.deepPurpleAccent.withOpacity(0.1),
          ),
          columns: const [
            DataColumn(
              label: Text(
                '#', // Contador de filas
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Dic',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Valor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Fecha',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Hora',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: pvPrincipal.modelDiccionarioNodo!.data!.map((item) {
            final fila = DataRow(
              cells: [
                DataCell(Text(contador.toString())), // Contador de filas
                DataCell(Text(item.nombreDiccionario ?? "Sin Nombre")),
                DataCell(Text(item.valor.toString())),
                DataCell(Text(DateFormat('yyyy-MM-dd').format(item.fechahora!))),
                DataCell(Text(item.hora!)),
              ],
            );
            contador++; // Incrementa el contador después de cada fila
            return fila;
          }).toList(),
          dividerThickness: 1,
          dataRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white,
          ),
          dataRowHeight: 48,
          headingTextStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


