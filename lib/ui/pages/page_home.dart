import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/pages/page_nodos.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

import '../utils/global_gps.dart';
import '../widgets/widget_appbar.dart';
import '../widgets/widget_carousel.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);
  static const routePage = Global.routeHome;

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  ProviderLogin? pLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pLogin = Provider.of<ProviderLogin>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Gps().checkGPS().then((value) {});
      pLogin!.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyHome();
  }
}

class BodyHome extends StatelessWidget {
  BodyHome({Key? key}) : super(key: key);
  ProviderLogin? pLogin;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pLogin ??= Provider.of<ProviderLogin>(context);
    return AnnotatedRegion(
      value: ColorsPalette.colorWhite,
      child: Scaffold(
        appBar: widgetAppBarHome(pLogin!.empresaResponse!.imagen ?? "", pLogin!.empresaResponse!.nombre_empresa ?? ""),
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
                gpsLocation(),
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
          Navigator.of(Utils.globalContext.currentContext!).pushNamed(PageNodos.routePage);
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
          pLogin!.onCameraCenter(CameraPosition(target: LatLng(Gps.latitude, Gps.longitude), zoom: 15));
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
            itemCount: pLogin!.empresaNodosResponse.length,
            itemBuilder: (context, int index, index2) {
              return CarouselSliderNodos(
                title: pLogin!.empresaNodosResponse[index].nombre,
                subtitle: pLogin!.empresaNodosResponse[index].fechahora,
                type: pLogin!.empresaNodosResponse[index].tipoDato,
                valor: pLogin!.empresaNodosResponse[index].valor,

              );
            },
            options: CarouselOptions(
                viewportFraction:
                    pLogin!.empresaNodosResponse.isNotEmpty && pLogin!.empresaNodosResponse.length > 1 ? 0.9 : 1,
                scrollDirection: Axis.horizontal,
                autoPlay: pLogin!.empresaNodosResponse.isNotEmpty && pLogin!.empresaNodosResponse.length > 1 ? true : false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                height: 190,
                onPageChanged: (index, reason) {
                  pLogin!.position = index;
                },
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                enableInfiniteScroll:
                    pLogin!.empresaNodosResponse.isNotEmpty && pLogin!.empresaNodosResponse.length > 1 ? true : false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                disableCenter: true,
                padEnds:
                    (pLogin!.empresaNodosResponse.isNotEmpty && pLogin!.empresaNodosResponse.length > 1) ? false : true),
          ),
        ),
      ],
    );
  }
}

class GoogleMaps extends StatelessWidget {
  GoogleMaps({Key? key}) : super(key: key);
  ProviderLogin? pvLogin;

  @override
  Widget build(BuildContext context) {
    pvLogin ??= Provider.of<ProviderLogin>(context);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(Gps.latitude, Gps.longitude),
        zoom: 10.8,
      ),
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        pvLogin!.initMapExplorer(controller);
        pvLogin!.googleMapController = controller;
        pvLogin!.googleMapController.setMapStyle(pvLogin!.styleMapGoogle());
      },
      // markers: Set<Marker>.of(providerCarpool.markersExplorer.values),
    );
  }
}
