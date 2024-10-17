import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

import '../widgets/widget_appbar.dart';

class ScreenDataDeviceId extends StatefulWidget {
  const ScreenDataDeviceId({super.key});

  static const routePage = UsefulLabel.routerScreenDataDeviceId;

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
                NodoCard(),
                ListDataDeviceId(),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListDataDeviceId extends StatelessWidget {
  const ListDataDeviceId({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipalRead = context.watch<ProviderPrincipal>();

    if (pvPrincipalRead.datosDeviceID != null &&
        pvPrincipalRead.datosDeviceID!.ultimosDatos != null &&
        pvPrincipalRead.datosDeviceID!.ultimosDatos!.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(100.0), // Ancho fijo para la primera columna
            1: FlexColumnWidth(), // Ancho flexible para la segunda columna
            2: FlexColumnWidth(), // Ancho flexible para la segunda columna
          },
          children: [
            // Encabezado de la tabla
            TableRow(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: Colors.grey[200]),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Variable",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Estado",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Dato",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Filas de datos
            for (var item in pvPrincipalRead.datosDeviceID!.ultimosDatos!) ...[
              TableRow(
                children: [
                  // Columna Alias
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.alias ?? 'N/A'),
                  ),
                  // Columna Detalles
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.identificador == 247 ||
                            item.identificador == 246 ||
                            item.identificador == 245) ...[
                          Row(
                            children: [
                              Icon(
                                item.valor == 1.0
                                    ? FontAwesomeIcons.toggleOn
                                    : FontAwesomeIcons.toggleOff,
                                color: item.valor == 1.0 ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 5.0),
                              Text(item.valor == 1.0 ? "ON" : "OFF")
                            ],
                          )
                        ] else ...[
                          pvPrincipalRead.getIconByIdentifier(item.identificador!)
                        ]
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.valor.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              // Separador entre filas
              const TableRow(
                children: [
                  TableCell(
                    child: Divider(thickness: 1, color: Colors.grey),
                  ),
                  TableCell(
                    child: Divider(thickness: 1, color: Colors.grey),
                  ),
                  TableCell(
                    child: Divider(thickness: 1, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    // Si no hay datos, retorna un contenedor vacío
    return Container();
  }
}

class NodoCard extends StatelessWidget {
  const NodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.watch<ProviderPrincipal>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.router,
              size: 150,
              color: Colors.blue,
            ),
            Container(
              child: Column(
                children: [
                  Text("${prPrincipalRead.datosDeviceID?.nodo?.nombrePresentar}"),
                  Text("${prPrincipalRead.datosDeviceID?.nodo?.nombre}"),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
