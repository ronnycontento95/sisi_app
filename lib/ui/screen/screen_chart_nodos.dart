import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

class ScreenChartNodos extends StatelessWidget {
  const ScreenChartNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCardNodos;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Hace la barra de estado transparente
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.light
          : Brightness.light, // Controla el brillo de los íconos
    );

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Imagen en el encabezado
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${ApiGlobalUrl.generalLinkImagen}${context.watch<ProviderPrincipal>().companyResponse.imagen}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const Icon(Icons.business, color: Colors.white,),
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ListChartNodos(),
              ),
            ],
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
      spacing: 16, // Más espacio entre los widgets
      runSpacing: 16, // Más espacio entre las filas
      children: List.generate(pvPrincipal.modelListNodos?.nodos?.length ?? 0, (index) {
        final device = pvPrincipal.modelListNodos?.nodos![index];

        return SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 24, // Ajuste para mantener un margen más consistente
          height: 180, // Ajusta la altura para darle más espacio al contenido
          child: GestureDetector(
            onTap: () {
              pvPrincipal.getDataDeviceId(device!.idNodos!, context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/tank.svg',
                      width: 80, // Reduzco el tamaño para dar más espacio a otros elementos
                      height: 80,
                      colorFilter: const ColorFilter.mode(
                        Colors.blue,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 10), // Espacio entre la imagen y el texto
                    Text(
                      device!.nombrePresentar!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5), // Espacio entre la imagen y el texto
                    Text(
                      device.nombre!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
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



class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: prPrincipalRead.editSearchDevice,
              autocorrect: true,
              autofocus: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.length > 3) {
                  prPrincipalRead.searchHistorialFilter(value);
                } else if (value.isEmpty) {
                  prPrincipalRead.cleanTextFieldSearch(context);
                }
              },
              style: TextStyle(color: UsefulColor.colorLetterTitle.withOpacity(.8)),
              decoration: InputDecoration(
                hintText: UsefulLabel.lblSearhDevice,
                contentPadding: const EdgeInsets.only(top: 10.0),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: UsefulColor.colorPrimary,
                ),
                hintStyle: TextStyle(color: UsefulColor.colorLetterTitle.withOpacity(.3)),
                filled: true,
                fillColor: UsefulColor.colorBackground,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: UsefulColor.colorPrimary, width: .5),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    prPrincipalRead.cleanTextFieldSearch(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: UsefulColor.colorPrimary,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: UsefulColor.colorBackground, width: .5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
