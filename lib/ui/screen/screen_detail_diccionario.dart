import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [TablaDiccionarioNodo()],
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
    if(pvPrincipal.modelDiccionarioNodo == null|| pvPrincipal.modelDiccionarioNodo!.data == null){
      return const Center(child: Text("No hay datos disponibles."));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,  // Permitir scroll horizontal si la tabla es ancha
        child: DataTable(
          columns: const [
            // DataColumn(label: Text('ID Datos')),
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Valor')),
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Hora')),
          ],
          rows: pvPrincipal.modelDiccionarioNodo!.data!.map((item) {
            return DataRow(cells: [
              // DataCell(Text(item.idDatos.toString())),    // ID Datos
              DataCell(Text("${item.nombreDiccionario}")),     // Nombre Diccionario
              DataCell(Text(item.valor.toString())),      // Valor
              DataCell(Text(item.fechahora!.toString())),             // Fecha
              DataCell(Text(item.hora!)),                  // Hora
            ]);
          }).toList(),
        ),
      ),
    );
  }
}


// Ejemplo de modelo
