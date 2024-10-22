import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

import '../widgets/widget_appbar.dart';

class ScreenDataDeviceId extends StatefulWidget {
  const ScreenDataDeviceId({super.key});

  static const routePage = UsefulLabel.routerScreenDetailDiccionario;

  @override
  State<ScreenDataDeviceId> createState() => _ScreenDataDeviceIdState();
}

class _ScreenDataDeviceIdState extends State<ScreenDataDeviceId> {
  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.watch<ProviderPrincipal>();
    return AnnotatedRegion(
      value: Colors.red,
      child: Scaffold(
        appBar: WidgetAppBarHome(
            imagen: prPrincipalRead.companyResponse.imagen ?? "",
            business: prPrincipalRead.companyResponse.nombre_empresa,
            topic: prPrincipalRead.companyResponse.topic ?? ""),
        backgroundColor: UsefulColor.colorBackgroundWhite,
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                CardNodo(),
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Cambia la dirección de la sombra
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.router_sharp,
                  size: 50,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${pvPrincipal.datosDiccionario!.nombrePresentar}"),
                    Text("${pvPrincipal.datosDiccionario!.nombre}"),
                  ],
                )
              ],
            )
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

    // Verificar si hay datos antes de renderizar
    if (pvPrincipal.datosDiccionario == null ||
        pvPrincipal.datosDiccionario!.data == null) {
      return const Center(child: Text("No hay datos disponibles."));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pvPrincipal.datosDiccionario!.data!.length,
      itemBuilder: (context, index) {
        final item = pvPrincipal.datosDiccionario!.data![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: DiccionarioItemCard(
              idDiccionario: item.idDiccionario,
              valor: item.valor,
              fechahora: item.fechahora,
              hora: item.hora,
              identificador: item.identificador,
              nombre: item.nombreDiccionario),
        );
      },
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

  const DiccionarioItemCard(
      {Key? key,
      this.idDiccionario,
      this.valor,
      this.fechahora,
      this.hora,
      this.nombre,
      this.identificador})
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
          color: UsefulColor.colorWhite,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Cambia la dirección de la sombra
            ),
          ],
        ),
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 70, child: pvPrincipal.getIconByIdentifier(identificador!)),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Variable: $nombre",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text("Valor: $valor",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Fecha: ${DateFormat('yyyy-MM-dd').format(fechahora!)}",
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Hora: $hora", style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
