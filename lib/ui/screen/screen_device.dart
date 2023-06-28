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
import '../widgets/widget_appbar.dart';
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
      pvPrincipal!.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyHome();
  }
}

class BodyHome extends StatelessWidget {
  ProviderPrincipal? pvPrincipal;

  BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pvPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
        value: UsefulColor.colorWhite,
        child: Scaffold(
          appBar: widgetNewAppBar(title: UsefulLabel.lblSearhDevice, fontSize: 20),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [cardNodosList()],
              ),
            ),
          ),
        ));
  }

  /// Search device
  Widget searchText(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: Icon(Icons.search))
          // Expanded(child: child)
        ],
      ),
    );
  }

  ///List card nodos
  Widget cardNodosList() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pvPrincipal!.listDevice.length,
        itemBuilder: (context, index) {
          return itemNodo(pvPrincipal!.listDevice[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, childAspectRatio: 2 / 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
      ),
    );
  }
  /// Item Nodos
  Widget itemNodo(Device? empresaNodos) {
    return GestureDetector(
      onTap: (){
        Navigator.of(Useful.globalContext.currentContext!).pushNamed(ScreenWebView.routePage);
        pvPrincipal!.companyWeb = empresaNodos;
      },
      child: Container(
        width: 150,
        height: 250,
        color: Colors.black26,
        child: SfRadialGauge(
          title: GaugeTitle(text: empresaNodos!.nombre!),
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 150,
              maximumLabels: 5,
              interval: 20,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 150,
                    color: empresaNodos.valor! < 55
                        ? Colors.orange
                        : (empresaNodos.valor! > 55 && empresaNodos.valor! < 80)
                            ? Colors.blue
                            : Colors.red,
                    startWidth: 10,
                    endWidth: 10),
              ],
              pointers: <GaugePointer>[NeedlePointer(value: empresaNodos.valor!)],
              annotations: const <GaugeAnnotation>[
                GaugeAnnotation(
                    widget:
                        Text('90.0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    angle: 90,
                    positionFactor: 0.5)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
