import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_web_device.dart';
import 'package:sisi_iot_app/ui/useful/useful.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';

class ScreenChartNodos extends StatelessWidget {
  const ScreenChartNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCardNodos;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // TextFieldSearch(),
          SizedBox(
            height: 10,
          ),
          ListChartNodos()
        ],
      ),
    );
  }
}

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return Row(
      children: [
        TextFormField(
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
            prefixIcon: const Icon(Icons.search_outlined),
            hintStyle: TextStyle(color: UsefulColor.colorLetterTitle.withOpacity(.3)),
            filled: true,
            fillColor: UsefulColor.colorBackground,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: Colors.red, width: .5),
            ),
            suffixIcon: InkWell(
              onTap: () {
                prPrincipalRead.cleanTextFieldSearch(context);
              },
              child: const Icon(Icons.close),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: UsefulColor.colorBackground, width: .5),
            ),
          ),
        ),
      ],
    );
  }
}

class ListChartNodos extends StatelessWidget {
  const ListChartNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return SizedBox(
      height: 146,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 10, // Espacio entre columna
          childAspectRatio: 4.2 / 3.5, // Proporción de ancho/alto de cada item
        ),
        itemCount: pvPrincipal.listFilterDevice?.length,
        itemBuilder: (context, index) {
          final device = pvPrincipal
              .listFilterDevice![index]; // Obteniendo cada dispositivo de la lista
          return Container(
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 125,
            child: GestureDetector(
              onTap: () {
                pvPrincipal.idWebDevice = device.ide!;
                Navigator.of(Useful.globalContext.currentContext!).pushNamed(
                  ScreenWebView.routePage,
                  arguments: device.ide,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        color: UsefulColor.colorPrimary),
                    child: Center(
                        child: Text(
                      device.nombre!.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: UsefulColor.colorWhite),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: UsefulColor.colorPrimary),
                              child: Center(
                                  child: WidgetViewLabelText().labelTextTitle(
                                      text: "${device.valor} %",
                                      fontSize: 25,
                                      colortext: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
