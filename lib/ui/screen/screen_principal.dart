import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/config/global_url.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_home.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_network.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

class ScreenChartNodos extends StatelessWidget {
  const ScreenChartNodos({super.key});

  static const routePage = UsefulLabel.routerScreenPrincipal;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Hace la barra de estado transparente
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.dark, // Controla el brillo de los íconos
    );

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: RefreshIndicator(
        onRefresh: () => context.read<ProviderPrincipal>().getDataBusiness(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${ApiGlobalUrl.generalLinkImagen}${context.watch<ProviderPrincipal>().companyResponse.imagen}'),
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.business,
                              color: Colors.white,
                            ),
                            Text(
                              '${context.watch<ProviderPrincipal>().companyResponse.nombre_empresa} ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 12.0,
                                    color: Colors.black45,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetNetwork.alert(
                  textAlert: 'Revisa tu conexión de internet e intenta nuevamente',
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListChartNodos(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListChartNodos extends StatelessWidget {
  const ListChartNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(pvPrincipal.modelListNodos?.nodos?.length ?? 0, (index) {
        final device = pvPrincipal.modelListNodos?.nodos![index];
        if (device == null) {
          return const SizedBox.shrink();
        }

        // Configuración de color y porcentaje basado en el valor del nodo
        final double valor = device.valor ?? 0.0;
        final double porcentaje = (valor / 100).clamp(0.0, 1.0);
        final Color color = valor >= device.valorMaximo!
            ? Colors.redAccent
            : valor <= device.valorMinimo!
                ? Colors.orangeAccent
                : UsefulColor.colorPrimary;

        return GestureDetector(
          onTap: () {
            pvPrincipal.getDataDeviceId(device.idNodos!, context);
          },
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 150),
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 24,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Encabezado con etiqueta de estado y nombre
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          device.nombrePresentar?.toUpperCase() ?? "SIN NOMBRE",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: color,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    pvPrincipal.modelListNodos!.idEmpresa == '2'
                        ? 'assets/images/glp.svg'
                        : 'assets/images/tank.svg',
                    width: 60,
                    height: 60,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),

                  // Valor del nodo en el centro
                  Text(
                    "${device.valor ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),

                  // Barra de progreso horizontal en la parte inferior
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: porcentaje,
                        backgroundColor: Colors.grey.shade300,
                        color: color,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
