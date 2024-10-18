import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

class ScreenChartNodos extends StatelessWidget {
  const ScreenChartNodos({super.key});

  static const routePage = UsefulLabel.routerScreenCardNodos;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TextFieldSearch(),
          SizedBox(
            height: 10,
          ),
          ListChartNodos(),
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

class ListChartNodos extends StatelessWidget {
  const ListChartNodos({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(pvPrincipal.listFilterDevice?.length ?? 0, (index) {
        final device = pvPrincipal.listFilterDevice![index];
        return SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 25, // Ajuste para dos columnas
          height: 155,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: GestureDetector(
                  onTap: () {
                    pvPrincipal.getDataDeviceId(device.ide!, context);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/tank.svg',
                            width: 100,
                            height: 100,
                            colorFilter: ColorFilter.mode(
                              device.valor! > 100
                                  ? Colors.red
                                  : device.valor! <= 30
                                      ? Colors.orange
                                      : Colors.blue,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CardColor(
                                color: Colors.red,
                                text: "Alto",
                              ),
                              CardColor(
                                color: Colors.blue,
                                text: "Normal",
                              ),
                              CardColor(
                                color: Colors.orange,
                                text: "Bajo",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(device.nombre!.toUpperCase()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( "${device.valor ?? "0.0"}%"),
                  const SizedBox(width: 4), // Espacio entre el icono y el texto
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: UsefulColor.colorhintstyletext,
                  ),
                ],
              ),
            ],
          ),
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
