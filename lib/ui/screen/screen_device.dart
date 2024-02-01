import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../domain/entities/device.dart';
import '../provider/provider_principal.dart';
import '../useful/useful.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';
import 'screen_web_device.dart';

class ScreenDevice extends StatefulWidget {
  const ScreenDevice({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenDevice;

  @override
  State<ScreenDevice> createState() => _ScreenDeviceState();
}

class _ScreenDeviceState extends State<ScreenDevice> {
  ProviderPrincipal? pvPrincipal;

  @override
  void initState() {
    super.initState();
    pvPrincipal = Provider.of<ProviderPrincipal>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pvPrincipal!.getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBodyDevice();
  }
}

class ScreenBodyDevice extends StatelessWidget {
  ProviderPrincipal? pvPrincipal;

  ScreenBodyDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pvPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        // appBar: widgetNewAppBar(title: UsefulLabel.lblSearhDevice, fontSize: 20),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [_searchDevice(), _cardNodosList()],
            ),
          ),
        ),
      ),
    );
  }

  /// Card Device
  Widget _searchDevice() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        // controller: pvTax!.txt_search_history,
        autofocus: false,
        style: const TextStyle(fontSize: 14),
        textCapitalization: TextCapitalization.sentences,
        // cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            hintText: UsefulLabel.lblSearhDevice,
            prefixIcon: const Icon(Icons.search_rounded),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onChanged: (param) {
          pvPrincipal!.searchHistorialFilter(param);
        },
      ),
    );
  }

  ///List card nodos
  Widget _cardNodosList() {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pvPrincipal!.listFilterDevice!.length,
                itemBuilder: (context, index) {
                  return _itemNodo(pvPrincipal!.listFilterDevice![index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Item Nodos
  Widget _itemNodo(Device? device) {
    return GestureDetector(
      onTap: () {
        Navigator.of(Useful.globalContext.currentContext!).pushNamed(ScreenWebView.routePage);
        pvPrincipal!.companyWeb = device.ide!;
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
            color: UsefulColor.colorSecondary200),
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: UsefulColor.colorfocus,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: Text("${device!.nombre}"))),
            Row(
              children: [
                Expanded(
                  child: Text("Nodo: ${device.nombre!}\n"
                      "Dato: ${device.valor!}\n"
                      "Hora: ${device.fechahora!}\n"),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 130,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            axisLineStyle: const AxisLineStyle(thickness: 10),
                            showTicks: false,
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                  value: device.valor!.toDouble(),
                                  enableAnimation: true,
                                  needleStartWidth: 0,
                                  needleEndWidth: 5,
                                  needleColor: const Color(0xFFDADADA),
                                  knobStyle: const KnobStyle(
                                      color: Colors.white,
                                      borderColor: Color(0xFFDADADA),
                                      knobRadius: 0.06,
                                      borderWidth: 0.04),
                                  tailStyle: const TailStyle(color: Color(0xFFDADADA), width: 1, length: 0.15)),
                              const RangePointer(value: 60, width: 10, enableAnimation: true, color: Colors.blueAccent)
                            ])
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
