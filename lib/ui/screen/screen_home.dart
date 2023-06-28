///Import
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../global/global.dart';
import '../global/global_gps.dart';
import '../global/global_palette.dart';
import '../global/utils.dart';
///Utils

///Widgets
import '../widgets/widget_appbar.dart';
import '../widgets/widget_carousel.dart';

///Pages
import 'screen_device.dart';

/// Provider
import '../provider/provider_principal.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = Global.routeHome;

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
      Gps().checkGPS().then((value) {});
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
      value: ColorsPalette.colorWhite,
      child: Scaffold(
        appBar: widgetAppBarHome(pvPrincipal!.companyResponse.imagen ?? "", pvPrincipal!.companyResponse.nombre_empresa ?? ""),
        backgroundColor: ColorsPalette.colorGrey,
        body: Stack(
          children: [
            GoogleMaps(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconAnimation(),
                const SizedBox(
                  height: 15,
                ),
                // gpsLocation(),
              ],
            ),
            // listNodos()
            carouselSliderNodo(),
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
          Navigator.of(Utils.globalContext.currentContext!).pushNamed(ScreenDevice.routePage);
        },
        child: RippleAnimation(
          repeat: true,
          ripplesCount: 2,
          minRadius: 18,
          color: ColorsPalette.colorSecondary,
          child: const ClipOval(
            // backgroundColor: ColorsPalette.colorWhite,
            // radius: 18,
            child: Icon(Icons.wifi, color: ColorsPalette.colorSecondary),
            // backgroundImage: AssetImage("${Global.assetsIcons}water.gif"),
          )
        )
      ),
    );
  }

  /// Gps location
  Widget gpsLocation() {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          pvPrincipal!.onCameraCenter(CameraPosition(target: LatLng(Gps.latitude, Gps.longitude), zoom: 15));
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.gps_fixed,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
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
                viewportFraction:
                    pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1 ? 0.9 : 1,
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
                enableInfiniteScroll:
                    pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1 ? true : false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                disableCenter: true,
                padEnds:
                    (pvPrincipal!.listDevice.isNotEmpty && pvPrincipal!.listDevice.length > 1) ? false : true),
          ),
        ),
      ],
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
        target: LatLng(Gps.latitude, Gps.longitude),
        zoom: 10.8,
      ),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        pvPrincipal!.initMapExplorer(controller);
        pvPrincipal!.googleMapController = controller;
        pvPrincipal!.googleMapController.setMapStyle(pvPrincipal!.styleMapGoogle());
        pvPrincipal!.googleMapController.animateCamera(CameraUpdate.newLatLng(LatLng(Gps.latitude, Gps.longitude)));
      },
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(pvPrincipal!.markersExplorer.values),
    );
  }
}
