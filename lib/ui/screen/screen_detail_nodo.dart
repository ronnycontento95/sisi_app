import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

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
    return const Scaffold(
      backgroundColor: UsefulColor.colorBackgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Mejor alineación de los hijos
              children: [
                CardNodo(), // Añadimos espaciado entre las secciones
                CardDiccionario(),
              ],
            ),
          ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Añadimos esquinas redondeadas
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // Cambia la dirección de la sombra
            ),
          ],
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
      ),
    );
  }
}

class CardDiccionario extends StatelessWidget {
  const CardDiccionario({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.datosDiccionario == null ||
        pvPrincipal.datosDiccionario!.data == null) {
      return const Center(child: Text("No hay datos disponibles."));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Si no quieres scroll, usa esto
        itemCount: pvPrincipal.datosDiccionario!.data!.length,
        itemBuilder: (context, index) {
          final item = pvPrincipal.datosDiccionario!.data![index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: DiccionarioItemCard(
              idDiccionario: item.idDiccionario,
              valor: item.valor,
              fechahora: item.fechahora,
              hora: item.hora,
              identificador: item.identificador,
              nombre: item.nombreDiccionario,
            ),
          );
        },
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

  const DiccionarioItemCard({
    Key? key,
    this.idDiccionario,
    this.valor,
    this.fechahora,
    this.hora,
    this.nombre,
    this.identificador,
  }) : super(key: key);

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
          color: UsefulColor.colorWhite,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: pvPrincipal.getIconByIdentifier(identificador!),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Variable: $nombre",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Valor: $valor",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
