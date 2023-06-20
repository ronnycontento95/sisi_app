import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/pages/page_web_nodos.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';
import 'package:sisi_iot_app/ui/widgets/widget_appbar.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PageNodos extends StatefulWidget {
  PageNodos({Key? key}) : super(key: key);
  static const routePage = Global.routePageNodos;

  @override
  State<PageNodos> createState() => _PageNodosState();
}

class _PageNodosState extends State<PageNodos> {
  ProviderLogin? pvLogin;

  @override
  void initState() {
    super.initState();
    pvLogin = Provider.of<ProviderLogin>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pvLogin!.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyHome();
  }
}

class BodyHome extends StatelessWidget {
  ProviderLogin? pvLogin;

  BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pvLogin ??= Provider.of<ProviderLogin>(context);
    return AnnotatedRegion(
        value: ColorsPalette.colorWhite,
        child: Scaffold(
          appBar: widgetNewAppBar(title: "Dispositivos IoT", fontSize: 20),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [cardNodosList()],
              ),
            ),
          ),
        ));
  }

  ///List card nodos
  Widget cardNodosList() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pvLogin!.empresaNodosResponse.length,
        itemBuilder: (context, index) {
          return itemNodo(pvLogin!.empresaNodosResponse[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, childAspectRatio: 2 / 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
      ),
    );
  }
  /// Item Nodos
  Widget itemNodo(EmpresaNodosResponse? empresaNodos) {
    return GestureDetector(
      onTap: (){
        Navigator.of(Utils.globalContext.currentContext!).pushNamed(PageWebView.routePage);
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
