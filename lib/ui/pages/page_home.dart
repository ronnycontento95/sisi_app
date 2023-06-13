import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/pages/page_nodos.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

import '../utils/gps.dart';
import '../widgets/widget_appbar.dart';

class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);
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
  ProviderLogin? pLogin;

  BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    pLogin ??= Provider.of<ProviderLogin>(context);
    return AnnotatedRegion(
      value: ColorsPalette.colorWhite,
      child: Scaffold(
        appBar: WidgetAppbarHome(pLogin!.empresaResponse!.imagen!, pLogin!.empresaResponse!.nombre_empresa!),
        backgroundColor: ColorsPalette.colorGrey,
        body: Stack(
          children: [
            const GoogleMaps(),
            locationGps(),
            listNodos()
          ],
        ),
      ),
    );
  }

  /// Gps location
  Widget locationGps() {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(Utils.globalContext.currentContext!).pushNamed(PageNodos.routePage);
        },
        child: const Icon(
          Icons.gps_fixed,
          size: 30,
          color: Colors.red,
        ),
      ),
    );
  }

  /// Lista de nodos
  Widget listNodos() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const  Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 90),
                  pauseAutoPlayOnTouch: true,
                  enableInfiniteScroll: true,
                ),
                items: pLogin!.empresaNodosResponse.map((element) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child:Text("${element.nombre}")
                      );
                    },
                  );
                }).toList(),
              );
            },
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150, childAspectRatio: 2 / 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          ),
        ),
      ],
    );
  }

}

class GoogleMaps extends StatelessWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(Gps.latitude, Gps.longitude),
        zoom: 10.8,
      ),

      myLocationEnabled: false,
      zoomControlsEnabled: true,
      onMapCreated: (controller) {
        // providerCarpool.initMapExplorer(controller);
      },
      // markers: Set<Marker>.of(providerCarpool.markersExplorer.values),
    );
  }

}
