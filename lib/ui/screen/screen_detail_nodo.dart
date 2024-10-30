import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_bar_chart.dart';
import 'package:sisi_iot_app/ui/widgets/widget_water_level.dart';

import '../widgets/widget_appbar.dart';

class ScreenDetailNodo extends StatefulWidget {
  const ScreenDetailNodo({super.key});

  static const routePage = UsefulLabel.routerScreenDetailNodo;

  @override
  State<ScreenDetailNodo> createState() => _ScreenDataDeviceIdState();
}

class _ScreenDataDeviceIdState extends State<ScreenDetailNodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Datos del nodo",
          style: TextStyle(color: Colors.black, letterSpacing: 3),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const CardNodo();
                }, childCount: 1),
              ),
              const SliverGridComponent()
            ],
          ),
        ),
      ),
    );
  }
}

class SliverGridComponent extends StatelessWidget {
  const SliverGridComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    if (pvPrincipal.datosDiccionario == null ||
        pvPrincipal.datosDiccionario!.data == null) {
      return const Center(child: Text("No hay datos disponibles."));
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = pvPrincipal.datosDiccionario!.data![index];
        return DiccionarioItemCard(
          idDiccionario: item.idDiccionario,
          valor: item.valor,
          fechahora: item.fechahora,
          hora: item.hora,
          identificador: item.identificador,
          nombre: item.nombreDiccionario,
          alias: item.alias_diccionario,
        );
      },
          childCount: pvPrincipal.datosDiccionario!.data!
              .length // Asegúrate de especificar el número de elementos
          ),
    );
  }
}

class DiccionarioItemCard extends StatelessWidget {
  final int? idDiccionario;
  final double? valor;
  final DateTime? fechahora;
  final String? hora;
  final String? nombre;
  final int? identificador;
  final String? alias;

  const DiccionarioItemCard(
      {Key? key,
      this.idDiccionario,
      this.valor,
      this.fechahora,
      this.hora,
      this.nombre,
      this.identificador,
      this.alias})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return InkWell(
      onTap: () {
        if (pvPrincipal.datosDiccionario != null ||
            pvPrincipal.datosDiccionario!.data != null) {
          pvPrincipal.getDataDiccionarioIdNodoId(
              pvPrincipal.datosDiccionario!.idNodo!, idDiccionario!, context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0), // Esquinas redondeadas
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Sombra suave
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0), // Más padding interno
        child: Column(
          children: [
            pvPrincipal.getIconByIdentifier(identificador!),
            Text(
              "$alias",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Valor: $valor ",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Fecha: ${DateFormat('yyyy-MM-dd').format(fechahora!)}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 10),
            Text(
              "Hora: $hora",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNodo extends StatelessWidget {
  const CardNodo({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.datosDiccionario == null ||
        pvPrincipal.datosDiccionario!.data == null) {
      return const Center(child: Text("No hay datos disponibles."));
    }

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Añadimos esquinas redondeadas
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.router_sharp,
            size: 50,
            color: UsefulColor.colorPrimary, // Añadimos color al ícono
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${pvPrincipal.datosDiccionario!.nombrePresentar}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${pvPrincipal.datosDiccionario!.nombre}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
