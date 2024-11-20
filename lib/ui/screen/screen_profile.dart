import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/config/global_url.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_terms.dart';

import 'package:sisi_iot_app/ui/widgets/widget_alert_dialog.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});
  static const routePage = CommonLabel.routeScreenProfile;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Imagen de perfil
                  CircleAvatar(
                    radius: 30, // Ajusta el tamaño para que sea pequeño
                    backgroundImage: NetworkImage(
                      '${ApiGlobalUrl.generalLinkImagen}${pvPrincipal.companyResponse.imagen}',
                    ),
                    backgroundColor: Colors
                        .transparent, // Si quieres eliminar cualquier borde de fondo
                  ),

                  const SizedBox(height: 16),
                  // Nombre de la empresa
                  Text(
                    "${pvPrincipal.companyResponse.nombre_empresa}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   "${pvPrincipal.companyResponse.descripcion}",
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading:
                            Icon(Icons.info_outline, color: CommonColor.colorPrimary),
                        title: const Text(
                          "Acerca de la app",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(ScreenTermCondition.routePage);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.description_outlined,
                            color: CommonColor.colorPrimary),
                        title: const Text(
                          "Términos y condiciones",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(ScreenTermCondition.routePage);
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: CommonColor.colorPrimary),
                        title: const Text(
                          "Cerrar sesión",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          showConfirmationAlert(
                            context: context,
                            title: "Aviso",
                            subtitle: "¿Estás seguro de que deseas continuar?",
                            onConfirm: () => pvPrincipal.logoOut()
                            ,
                          );

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
