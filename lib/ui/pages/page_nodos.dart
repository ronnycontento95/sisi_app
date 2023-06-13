import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
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
  ProviderLogin? pLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pLogin = Provider.of<ProviderLogin>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pLogin!.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyHome();
  }
}

class BodyHome extends StatelessWidget {
  ProviderLogin? pLogin;

  BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pLogin ??= Provider.of<ProviderLogin>(context);
    return AnnotatedRegion(
        value: ColorsPalette.colorWhite,
        child: Scaffold(
          appBar: widgetAppBar(title: "Dispositovos IoT", fontSize: 25),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widgetCircle()
                ],
              ),
            ),
          ),
        ));
  }

  //Lisview
  Widget titleHome() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: WidgetLabelText()
          .labelTextTitle(text: "Lista de Nodos", fontSize: 20),
    );
  }
  Widget widgetCircle() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pLogin!.empresaNodosResponse.length,
        itemBuilder: (context, index) {
          return itemNodo(pLogin!.empresaNodosResponse[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
      ),
    );
  }

  Widget itemNodo(EmpresaNodosResponse? empresaNodos) {
    return Container(
        width: 150,
        height: 250,
        color: Colors.black26,
        child: SfRadialGauge(
            title: GaugeTitle(text: empresaNodos!.nombre!),

            axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: 150, maximumLabels: 5,interval: 20, ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 150,
                    color: empresaNodos.valor! < 55 ? Colors.orange : (empresaNodos.valor! > 55 && empresaNodos.valor! < 80 )? Colors.blue : Colors.red ,
                    startWidth: 10,
                    endWidth: 10),

              ], pointers: <GaugePointer>[
                NeedlePointer(value: empresaNodos.valor!)
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text('90.0',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    angle: 90,
                    positionFactor: 0.5)
              ])
            ]));
  }


  //TODO CODIGO DE INA IMGEN TRASPATENTE
  Uint8List kTransparentImage = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);
}
