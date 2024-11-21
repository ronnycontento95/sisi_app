import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';

import 'package:sisi_iot_app/ui/widgets/widget_water_volumen.dart';

class ScreenDetailNodo extends StatefulWidget {
  const ScreenDetailNodo({super.key});

  static const routePage = CommonLabel.routerScreenDetailNodo;

  @override
  State<ScreenDetailNodo> createState() => _ScreenDataDeviceIdState();
}

class _ScreenDataDeviceIdState extends State<ScreenDetailNodo> {
  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Datos del nodo",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.5),
        ),
        elevation: 2, // Añade profundidad
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black), // Color de iconos de AppBar
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const SliverGridComponentChart();
                }, childCount: 1),
              ),
              const SliverGridComponent(),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverGridComponentChart extends StatelessWidget {
  const SliverGridComponentChart({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    if (pvPrincipal.datosDiccionarioFilterType == null ||
        pvPrincipal.datosDiccionarioFilterType!.isEmpty) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: screenWidth * 2,
            child: Column(
              children: [
                for (int index = 0;
                    index < pvPrincipal.datosDiccionarioFilterType!.length;
                    index++) ...[
                  InkWell(
                    onTap: () {
                      final item = pvPrincipal.datosDiccionarioFilterType![index];
                      if (pvPrincipal.datosDiccionario?.data != null) {
                        pvPrincipal.getDataDiccionarioIdNodoId(
                          pvPrincipal.datosDiccionario!.idNodo!,
                          item.idDiccionario!,
                          context,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        const CardNodo(),
                        CustomPaint(
                          size: Size(screenWidth * 0.4, screenWidth * 0.4),
                          painter: GaugePainter(
                            value: pvPrincipal.datosDiccionarioFilterType![index].valor!,
                            minValue: pvPrincipal
                                .datosDiccionarioFilterType![index].valorMinimo!,
                            maxValue: pvPrincipal
                                .datosDiccionarioFilterType![index].valorMaximo!,
                          ),
                        ),
                        Text(
                          "Valor: ${pvPrincipal.datosDiccionarioFilterType![index].identificador}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fecha: ${DateFormat('yyyy-MM-dd').format(pvPrincipal.datosDiccionarioFilterType![index].fechahora!)}",
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "Hora: ${pvPrincipal.datosDiccionarioFilterType![index].hora}",
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index < pvPrincipal.datosDiccionarioFilterType!.length - 1)
                    const Divider(height: 20),
                  // Divider entre los elementos, excepto el último
                ],
              ],
            ),
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
        crossAxisSpacing: 0,
        mainAxisSpacing: 5,
        childAspectRatio: 1.1,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = pvPrincipal.datosDiccionario!.data![index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: DiccionarioItemCard(
            idDiccionario: item.idDiccionario,
            valor: item.valor,
            fechahora: item.fechahora,
            hora: item.hora,
            identificador: item.identificador,
            nombre: item.nombreDiccionario,
            alias: item.aliasDiccionario,
            aliasDiccionario: item.aliasDiccionario,
          ),
        );
      }, childCount: pvPrincipal.datosDiccionario!.data!.length),
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
  final String? aliasDiccionario;

  const DiccionarioItemCard(
      {Key? key,
      this.idDiccionario,
      this.valor,
      this.fechahora,
      this.hora,
      this.nombre,
      this.identificador,
      this.aliasDiccionario,
      this.alias})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return InkWell(
      onTap: () {
        if (pvPrincipal.datosDiccionario?.data != null) {
          pvPrincipal.getDataDiccionarioIdNodoId(
              pvPrincipal.datosDiccionario!.idNodo!, idDiccionario!, context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Sombra suave
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alias ?? "Sin alias",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${identificador}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              "${valor ?? "N/A"}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CommonColor.colorPrimary,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icono del identificador
                pvPrincipal.getIconByIdentifier(identificador!),
                const SizedBox(width: 15),
                // Información de fecha y hora
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fecha: ${DateFormat('yyyy-MM-dd').format(fechahora!)}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Hora: ${hora ?? "N/A"}",
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
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

class ChartNodoTypeDiccionario extends StatelessWidget {
  const ChartNodoTypeDiccionario({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${pvPrincipal.datosDiccionario!.nombre}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${pvPrincipal.datosDiccionario!.topic}",
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
