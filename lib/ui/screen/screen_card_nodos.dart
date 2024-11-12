import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

class ScreenPrincipal extends StatelessWidget {
  const ScreenPrincipal({super.key});

  static const routePage = UsefulLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: RefreshIndicator(
        onRefresh: () => context.read<ProviderPrincipal>().getDataBusiness(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return const TitleCardNodos();
                  }, childCount: 1),
                ),
                const ListCardNodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleCardNodos extends StatelessWidget {
  const TitleCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreEmpresa = context.read<ProviderPrincipal>().companyResponse?.nombre_empresa ?? "Empresa";
    final nodosCount = context.watch<ProviderPrincipal>().modelListNodos?.nodos?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$nombreEmpresa Nodos",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                "$nodosCount nodos activos",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class ListCardNodos extends StatelessWidget {
  const ListCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    final nodos = pvPrincipal.modelListNodos?.nodos;

    if (nodos == null || nodos.isEmpty) {
      return const Center(
        child: Text("No hay datos disponibles.", style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3.5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final itemNodo = nodos[index];
          final nombre = itemNodo.nombrePresentar?.isNotEmpty == true ? itemNodo.nombrePresentar! : "Sin nombre";
          final valor = itemNodo.valor ?? 0.0;

          // Definir colores basados en el valor del nodo
          Color valorColor;
          if (valor < 20) {
            valorColor = Colors.redAccent;
          } else if (valor < 70) {
            valorColor = Colors.orangeAccent;
          } else {
            valorColor = UsefulColor.colorPrimary;
          }

          return InkWell(
            onTap: () {
              if (itemNodo.idNodos != null) {
                pvPrincipal.getDataDeviceId(itemNodo.idNodos!, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("ID de nodo no disponible.")),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              elevation: 3,
              shadowColor: Colors.black12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Barra de progreso circular para mostrar el valor
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: (valor / 100).clamp(0.0, 1.0),
                      center: Text(
                        "${valor.toInt()}%",
                        style: TextStyle(fontSize: 12, color: valorColor, fontWeight: FontWeight.bold),
                      ),
                      progressColor: valorColor,
                      backgroundColor: Colors.grey.shade200,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(width: 18),

                    // Texto en el centro
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${valor}",
                            style: TextStyle(
                              fontSize: 14,
                              color: valorColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Flecha de acción
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: valorColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: valorColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: nodos.length,
      ),
    );
  }
}
