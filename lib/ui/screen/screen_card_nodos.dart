import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

class ScreenCardNodos extends StatelessWidget {
  const ScreenCardNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCharNodos;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [ListCardNodos()],
          ),
        ),
      ),
    );
  }
}

class ListCardNodos extends StatelessWidget {
  const ListCardNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    if (pvPrincipal.modelListNodos?.nodos == null ||
        pvPrincipal.modelListNodos!.nodos!.isEmpty) {
      return const Center(
        child: Text("No hay datos disponibles."),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final itemNodo = pvPrincipal.modelListNodos!.nodos![index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Text(
                  itemNodo.nombrePresentar ?? "Sin nombre",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  itemNodo.nombre ?? "Sin nombre de presentación",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }, childCount: pvPrincipal.modelListNodos!.nodos!.length),
    );
  }
}
