import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/widgets/widget_emply.dart';

class ChartFocoGrafica extends StatelessWidget {
  const ChartFocoGrafica({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    print('ronny >>> 1');

    // Validación inicial para mostrar datos o un contenedor vacío
    final focoGrafica = pvPrincipal.modelosNodosGraficos?.focoGrafica;
    if (focoGrafica == null || focoGrafica.isEmpty) {
      return const SizedBox.shrink();
    }

    // Construcción de la lista de elementos
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(), // Animación más fluida
      itemCount: focoGrafica.length,
      itemBuilder: (context, index) {
        final item = focoGrafica[index];
        return _buildItemCard(context, item, pvPrincipal);
      },
    );
  }

// Método para construir cada tarjeta
  Widget _buildItemCard(BuildContext context, dynamic item, ProviderPrincipal pvPrincipal) {
    return InkWell(
      onTap: () {
        // Acción cuando se toca la tarjeta
      },
      borderRadius: BorderRadius.circular(16), // Borde redondeado
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4), // Sombra suave
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade200, // Bordes ligeros
          ),
        ),
        child: Row(
          children: [
            // Ícono
            Center(
              child: Icon(
                Icons.crisis_alert_outlined,
                size: 40,
                color: item.valor == 0 ? Colors.black : Colors.red,
              ),
            ),
            const SizedBox(width: 16), // Espacio entre ícono y texto
            // Información textual
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Texto alineado a la izquierda
                children: [
                  // Alias
                  Text(
                    pvPrincipal.capitalize('${item.alias}'),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Fecha y hora
                  Text(
                    'Fecha y hora: ${item.fechahora}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Descripción
                  Text(
                    'Descripción: ${pvPrincipal.capitalize('${item.descripcion}')}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
