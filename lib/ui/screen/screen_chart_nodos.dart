import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFieldSearch(),
            SizedBox(
              height: 10,
            ),
            ListChartNodos(),
          ],
        ),
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
              prefixIcon: const Icon(Icons.search_outlined),
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
                child: const Icon(Icons.close),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: UsefulColor.colorBackground, width: .5),
              ),
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
    int _selectedValue = 1;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      spacing: 10,
      // Espacio horizontal entre los elementos
      runSpacing: 10,
      // Espacio vertical entre los elementos
      children: List.generate(pvPrincipal.listFilterDevice?.length ?? 0, (index) {
        final device = pvPrincipal.listFilterDevice![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width / 2 - 20, // Ajuste para dos columnas
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 120,
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
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/tank.svg', // Ruta del archivo SVG del tanque
                          width: 100,
                          height: 100,
                          colorFilter: ColorFilter.mode(
                              device.valor! > 100
                                  ? Colors.red
                                  : device.valor! <= 30
                                      ? Colors.orange
                                      : Colors.blue,
                              BlendMode.srcIn),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardColor(color: Colors.red, text: "Alto",),
                            CardColor(color: Colors.blue, text: "Normal",),
                            CardColor(color: Colors.orange, text: "Bajo",),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              device.nombre!.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  color: UsefulColor.colorPrimary),
            ),
            WidgetViewLabelText()
                .labelTextTitle(text: "${device.valor ?? "0.0"}%", fontSize: 12)
          ],
        );
      }),
    );
  }
}

class CardColor extends StatelessWidget {
  const CardColor({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10, // Ancho del contenedor
          height: 10, // Altura del contenedor
          color: color, // Color rojo
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    );
  }
}
