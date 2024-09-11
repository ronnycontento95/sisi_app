///Import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sisi_iot_app/ui/screen/screen_web_device.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../domain/entities/device.dart';

///Useful
import '../useful/useful.dart';
import '../useful/useful_palette.dart';

import '../useful/useful_style_map.dart';

///Widgets
import '../widgets/widget_appbar.dart';
import '../widgets/widget_carousel.dart';

import '../widgets/widget_dotted_dashed_line.dart';

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
    super.initState();
    pvPrincipal = Provider.of<ProviderPrincipal>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pvPrincipal!.getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const BodyHome();
  }
}

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  ProviderPrincipal? pvPrincipal;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pvPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        appBar: WidgetAppBarHome(
            imagen: pvPrincipal!.companyResponse.imagen ?? "",
            business: pvPrincipal!.companyResponse.nombre_empresa,
            topic: pvPrincipal!.companyResponse.topic ?? ""),
        backgroundColor: UsefulColor.colorWhite,
        body: PageView(
          controller: pvPrincipal!.controller,
          physics: pvPrincipal!.currentPageIndex == 0
              ? const NeverScrollableScrollPhysics()
              : const ClampingScrollPhysics(),
          onPageChanged: (index) {
            pvPrincipal!.currentPageIndex = index;
          },
          children: [
            GoogleMaps(),
            SingleChildScrollView(
              child: Column(
                children: [const TextFieldSearch(), _itemNodo()],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(child: listBodyCardNodo())),
          ],
        ),
      ),
    );
  }

  ///List card nodos

  /// Item Nodos
  Widget _itemNodo() {
    return SizedBox(
      height: 125,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 10, // Espacio entre columnas
          mainAxisSpacing: 10, // Espacio entre filas
          childAspectRatio: 3 / 2, // Proporción de ancho/alto de cada item
        ),
        itemCount: pvPrincipal!.listFilterDevice?.length,
        itemBuilder: (context, index) {
          final device = pvPrincipal!
              .listFilterDevice![index]; // Obteniendo cada dispositivo de la lista

          return GestureDetector(
            onTap: () {
              pvPrincipal!.idWebDevice = device.ide!;
              Navigator.of(Useful.globalContext.currentContext!).pushNamed(
                ScreenWebView.routePage,
                arguments: device.ide,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black12),
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
                      device!.nombre!.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: UsefulColor.colorWhite),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
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

  /// Gps location
  Widget iconAnimation() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 15),
      child: GestureDetector(
          onTap: () {
            Navigator.of(Useful.globalContext.currentContext!)
                .pushNamed(ScreenDevice.routePage);
          },
          child: const RippleAnimation(
              repeat: true,
              ripplesCount: 2,
              minRadius: 18,
              color: UsefulColor.colorSecondary,
              child: ClipOval(
                child: Icon(Icons.wifi, color: UsefulColor.colorSecondary),
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
                viewportFraction: pvPrincipal!.listDevice.isNotEmpty &&
                        pvPrincipal!.listDevice.length > 1
                    ? 0.9
                    : 1,
                scrollDirection: Axis.horizontal,
                autoPlay: pvPrincipal!.listDevice.isNotEmpty &&
                        pvPrincipal!.listDevice.length > 1
                    ? true
                    : false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                height: 190,
                onPageChanged: (index, reason) {
                  pvPrincipal!.position = index;
                },
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                enableInfiniteScroll: pvPrincipal!.listDevice.isNotEmpty &&
                        pvPrincipal!.listDevice.length > 1
                    ? true
                    : false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                disableCenter: true,
                padEnds: (pvPrincipal!.listDevice.isNotEmpty &&
                        pvPrincipal!.listDevice.length > 1)
                    ? false
                    : true),
          ),
        ),
      ],
    );
  }

  /// Card List Nodos()

  /// Item nodos
  Widget listBodyCardNodo() {
    return SizedBox(
      height: 135,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          // crossAxisSpacing: 5, // Espacio entre columnas
          // mainAxisSpacing: 5, // Espacio entre filas
          childAspectRatio: 3 / 2, // Proporción de ancho/alto de cada item
        ),
        itemCount: pvPrincipal!.listFilterDevice!.length, // Tu lista de dispositivos
        itemBuilder: (context, index) {
          final device = pvPrincipal!
              .listFilterDevice![index]; // Obteniendo cada dispositivo de la lista

          return GestureDetector(
            onTap: () {
              pvPrincipal!.idWebDevice = device.ide!;
              Navigator.of(Useful.globalContext.currentContext!).pushNamed(
                ScreenWebView.routePage,
                arguments: device.ide, // Pasar el valor como argumento
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  device.nombre!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                  text: "Nivel:",
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Text(
                                  "${device.valor!}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                  text: "Hora:",
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Text(
                                  pvPrincipal!.extractTime(device.fechahora!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const WidgetDottedDashedLine(),
                            Row(
                              children: [
                                WidgetTextView.title(
                                    text: "Fecha:", size: 14, color: Colors.white),
                                const Spacer(),
                                Text(
                                  pvPrincipal!.extractDate(device.fechahora!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 10,
        left: 10,
      ),
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: UsefulColor.colorBackground,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: UsefulColor.colorBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
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
                      style:
                          TextStyle(color: UsefulColor.colorLetterTitle.withOpacity(.8)),
                      decoration: InputDecoration(
                        hintText: UsefulLabel.lblSearhDevice,
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        prefixIcon: const Icon(Icons.search_outlined),
                        hintStyle: TextStyle(
                            color: UsefulColor.colorLetterTitle.withOpacity(.3)),
                        filled: true,
                        fillColor: UsefulColor.colorBackground,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: UsefulColor.colorBackground, width: .5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: UsefulColor.colorBackground, width: .5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: GestureDetector(
                      onTap: () {
                        prPrincipalRead.cleanTextFieldSearch(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.close_rounded,
                              size: 20, color: UsefulColor.colorBlack)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
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
    return PageView(
      children: [
        Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-1.2394663499056315, -78.65732525997484),
                tilt: 0,
                bearing: 0,
                zoom: 11.0,
              ),
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (controller) {
                pvPrincipal!.googleMapController = controller;
                pvPrincipal!.googleMapController
                    .setMapStyle(jsonEncode(styleMapGoogle).toString());
                pvPrincipal!.googleMapController.animateCamera(CameraUpdate.newLatLng(
                    const LatLng(-4.009051005165443, -79.20641913069285)));
              },
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(pvPrincipal!.markers.values),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    pvPrincipal!.controller.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: UsefulColor.colorPrimary,
                    ),
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
