import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';

class ScreenPrincipal extends StatelessWidget {
  const ScreenPrincipal({super.key});

  static const routePage = CommonLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
    Theme.of(context).brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Panel de Nodos'),
          backgroundColor: CommonColor.colorPrimary,
        ),
        body: Consumer<ProviderPrincipal>(
          builder: (context, provider, child) {
            final nodos = provider.modelNodos.nodos;
            if (nodos!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final itemNodo = nodos[index];
                        final nombre = itemNodo.nombre?.isNotEmpty == true ? itemNodo.nombre! : "Sin nombre";
                        final valor = itemNodo.valor ?? 0.0;

                        // Determinar el color del nodo basado en el valor
                        Color valorColor;
                        if (valor < 20) {
                          valorColor = Colors.redAccent;
                        } else if (valor < 70) {
                          valorColor = Colors.orangeAccent;
                        } else {
                          valorColor = CommonColor.colorPrimary;
                        }

                        return InkWell(
                          onTap: () {
                            if (itemNodo.ide != null) {
                              provider.getGraficasNodos(itemNodo.ide!, context);
                            }
                          },
                          borderRadius: BorderRadius.circular(18.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.15),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        nombre,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "Valor: ${valor.toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: valorColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircularPercentIndicator(
                                    radius: 40.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    percent: valor / 100,
                                    center: Text(
                                      '${(valor).toStringAsFixed(0)}%',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    progressColor: valorColor,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: nodos.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
