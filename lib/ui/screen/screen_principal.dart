import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/config/global_url.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/screen/screen_profile.dart';

import 'package:sisi_iot_app/ui/widgets/widget_network.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenChartNodos extends StatelessWidget {
  const ScreenChartNodos({super.key});

  static const routePage = CommonLabel.routerScreenPrincipal;

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
        color: Colors.blueAccent, // Color del indicador de refresco
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: (){
                        // ScreenProfile();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ScreenProfile()),
                        // );
                        // Navigator.pushNamed(context, CommonLabel.routeScreenProfile);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        padding:
                            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: CommonColor.colorPrimary,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.business,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${context.watch<ProviderPrincipal>().companyResponse.nombre_empresa}",
                                    style: const TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                  const Text("Empresa", style: const TextStyle(fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Alerta de red
                    WidgetNetwork.alert(
                      textAlert: 'Revisa tu conexión de internet e intenta nuevamente',
                    ),

                    const SizedBox(height: 16.0),

                    // Contenedor de gráficos
                    const ListChartNodos(),
                  ],
                ),
              ),
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
      children: List.generate(pvPrincipal.modelNodos.nodos?.length ?? 0, (index) {
        final device = pvPrincipal.modelNodos.nodos![index];
        if (device.ide == null) {
          return const SizedBox.shrink();
        }

        final int valor = device.valor!;
        final double porcentaje = (valor / 100).clamp(0.0, 1.0);
        final Color color = valor >= device.valMax!
            ? Colors.redAccent
            : valor <= device.valMin!
                ? Colors.orangeAccent
                : CommonColor.colorPrimary;

        return GestureDetector(
          onTap: () {
            pvPrincipal.getDataDeviceId(device.ide!, context);
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage("${CommonLabel.assetsImages}circle.gif"),
                          width: 15,
                          color: color,
                        ),
                        const SizedBox(width: 8.0), // Espaciado entre la imagen y el texto
                        Expanded( // Asegura que el texto se ajuste al espacio disponible
                          child: Text(
                            device.nombre != null ? device.nombre! : "SIN NOMBRE",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1, // Limita el texto a una línea
                            overflow: TextOverflow.ellipsis, // Agrega los puntos suspensivos (...)
                          ),
                        ),
                      ],
                    ),
                  ),

                  SvgPicture.asset(
                    'assets/images/tank.svg',
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
                  Text(
                    "${device.tipoDato ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      // color: color,
                    ),
                  ),

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
