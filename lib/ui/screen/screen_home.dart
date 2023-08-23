///Import
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sisi_iot_app/ui/screen/screen_web_device.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../domain/entities/device.dart';

///Useful
import '../useful/useful.dart';
import '../useful/useful_palette.dart';

///Widgets
import '../widgets/widget_appbar.dart';
import '../widgets/widget_carousel.dart';

///Pages
import 'screen_device.dart';

/// Provider
import '../provider/provider_principal.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeHome;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  ProviderPrincipal? pvPrincipal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pvPrincipal = Provider.of<ProviderPrincipal>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // UsefulGps().checkGPS().then((value) {});
      pvPrincipal!.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyHome();
  }
}

class BodyHome extends StatelessWidget {
  BodyHome({Key? key}) : super(key: key);
  ProviderPrincipal? pvPrincipal;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pvPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        appBar: widgetAppBarHome(pvPrincipal!.companyResponse.imagen ?? "", pvPrincipal!.companyResponse.nombre_empresa ?? ""),
        backgroundColor: UsefulColor.colorWhite,
        body: PageView(
          controller: pvPrincipal!.controller,
          children: [
            GoogleMaps(),
            SingleChildScrollView(
              child: Column(
                children: [_searchDevice(), _cardNodosList()],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(child: _cardNodosListBody())),
          ],
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
            hintText: "Buscar", prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
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
      // onTap: () {
      //   Navigator.of(Useful.globalContext.currentContext!).pushNamed(ScreenWebView.routePage);
      //   print('>>>>> IDE WEB ${device.ide}');
      //   pvPrincipal!.companyWeb = device.ide!;
      // },
      onTap: () {
        Navigator.of(Useful.globalContext.currentContext!).pushNamed(
          ScreenWebView.routePage,
          arguments: device.ide, // Pasar el valor como argumento
        );
      },

      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)), color: UsefulColor.colorSecondary200),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
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
                  child: Text("Dato: ${device.valor!}\n"
                      "Maximo: ${device.valMax!}\n"
                      "Minimo: ${device.valMin!}\n"
                      "Hora: ${pvPrincipal!.extractTime(device.fechahora!)}\n"
                      "Fecha: ${pvPrincipal!.extractDate(device.fechahora!)}\n"), // Llama a la función para extraer la fecha
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 130,
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          interval: 10,
                          startAngle: 0,
                          endAngle: 360,
                          showTicks: false,
                          showLabels: false,
                          axisLineStyle: AxisLineStyle(thickness: 20),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: device.valor!,
                                width: 20,
                                color: device.valor! >= device.valMax!
                                    ? Colors.red
                                    : device.valor! <= device.valMin!
                                        ? Colors.yellow
                                        : Colors.blueAccent,
                                enableAnimation: true,
                                cornerStyle: CornerStyle.bothCurve)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 45.00,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      child: Container(
                                        child: Text('${device.valor}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ),
                                    )
                                  ],
                                ),
                                angle: 270,
                                positionFactor: 0.1)
                          ])
                    ]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Gps location
  Widget iconAnimation() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 15),
      child: GestureDetector(
          onTap: () {
            Navigator.of(Useful.globalContext.currentContext!).pushNamed(ScreenDevice.routePage);
          },
          child: RippleAnimation(
              repeat: true,
              ripplesCount: 2,
              minRadius: 18,
              color: UsefulColor.colorSecondary,
              child: const ClipOval(
                // backgroundColor: UsefulColor.colorWhite,
                // radius: 18,
                child: Icon(Icons.wifi, color: UsefulColor.colorSecondary),
                // backgroundImage: AssetImage("${Global.assetsIcons}water.gif"),
              ))),
    );
  }

  /// CarouselSlider nodos
  Widget carouselSliderNodo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 150,
          child: CarouselSlider.builder(
            itemCount: pvPrincipal!.listDevice.length,
            itemBuilder: (context, int index, index2) {
              return WidgetViewCarousel(
                title: pvPrincipal!.listDevice[index].nombre,
                subtitle: pvPrincipal!.listDevice[index].fechahora,
                type: pvPrincipal!.listDevice[index].tipoDato,
                valor: pvPrincipal!.listDevice[index].valor,
              );
            },
            options: CarouselOptions(
                viewportFraction: pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1 ? 0.9 : 1,
                scrollDirection: Axis.horizontal,
                autoPlay: pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1 ? true : false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                height: 190,
                onPageChanged: (index, reason) {
                  pvPrincipal!.position = index;
                },
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                enableInfiniteScroll: pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1 ? true : false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                disableCenter: true,
                padEnds: (pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1) ? false : true),
          ),
        ),
      ],
    );
  }

  /// Card List Nodos()
  Widget _cardNodosListBody() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: pvPrincipal!.listFilterDevice!.map((device) {
        return _itemNodoBody(device);
      }).toList(),
    );
  }

  /// Item nodos
  Widget _itemNodoBody(Device? device) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      // color: Colors.black12,
      width: MediaQuery.of(Useful.globalContext.currentContext!).size.width * 0.4,
      padding: EdgeInsets.only(right: 5, left: 5),
      margin: EdgeInsets.only(left: 2, right: 2, bottom: 5, top: 5), // Margen entre elementos
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${device!.nombre!}"),
              Icon(Icons.circle, color: Colors.red, size: 10,)
            ],
          ),
          Text(
                "Dato: ${device.valor!}\n"
                "Maximo: ${device.valMax!}\n"
                "Minimo: ${device.valMin!}\n"
                "Hora: ${pvPrincipal!.extractTime(device.fechahora!)}\n"
                "Fecha: ${pvPrincipal!.extractDate(device.fechahora!)}\n",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }


}

class GoogleMaps extends StatelessWidget {
  GoogleMaps({Key? key}) : super(key: key);
  ProviderPrincipal? pvPrincipal;

  @override
  Widget build(BuildContext context) {
    pvPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(-1.2394663499056315, -78.65732525997484),
        zoom: 5.5,
      ),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        // pvPrincipal!.initMapExplorer(controller);
        pvPrincipal!.googleMapController = controller;
        // pvPrincipal!.googleMapController.setMapStyle(pvPrincipal!.styleMapGoogle());
        pvPrincipal!.googleMapController.animateCamera(CameraUpdate.newLatLng(LatLng(-4.009051005165443, -79.20641913069285)));
      },
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(pvPrincipal!.markersExplorer.values),
    );
  }
}

