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
            pvPrincipal.getGraficasNodos(device.ide!, context);
          },
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 150),
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 24,
              height: 270, // Altura ajustada para una mejor distribución
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Espaciado uniforme
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: const AssetImage("${CommonLabel.assetsImages}circle.gif"),
                          width: 16,
                          color: color,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            device.nombre ?? "SIN NOMBRE",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.more_vert, // Menú para posibles acciones futuras
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                      ],
                    ),


                    const SizedBox(height: 10), // Separador entre encabezado y el icono

                    // Icono central (tanque)
                    SvgPicture.asset(
                      pvPrincipal.companyResponse.id_empresas  == 1? 'assets/images/tank.svg': 'assets/images/glp.svg',
                      width: 80,
                      height: 80,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),

                    const SizedBox(height: 12), // Separador entre icono y datos principales

                    // Fila con porcentaje y hora
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Nivel:",
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                            Text(
                              "${device.valor ?? 'N/A'}%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Última Hora:",
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                            Text(
                              device.hora ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8), // Espaciado entre fila y barra de progreso

                    // Barra de progreso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: porcentaje,
                        backgroundColor: Colors.grey.shade300,
                        color: color,
                        minHeight: 8,
                      ),
                    ),

                    const SizedBox(height: 12), // Separador entre barra y tipo de dato

                    // Tipo de dato y fecha
                    Column(
                      children: [
                        Text(
                          device.tipoDato ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          device.fecha ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );


      }),
    );
  }
}
