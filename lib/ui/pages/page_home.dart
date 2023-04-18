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
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
        appBar: AppBar(
          leading: pLogin!.empresaResponse?.imagen != null
              ? CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorsPalette.colorWhite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.memoryNetwork(
                      imageErrorBuilder: (context, _, __) {
                        return Icon(Icons.person);
                      },
                      placeholderErrorBuilder: (_, __, stackTrace) {
                        return Icon(Icons.person);
                      },
                      placeholder: kTransparentImage,
                      image:
                          "${ApiGlobalUrl.GENERAL_LINK}/${pLogin!.empresaResponse?.imagen ?? ""}",
                      height: 40,
                    ),
                  ),
                )
              : const SizedBox(),
          // you can put Icon as well, it accepts any widget.
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Hola, ',
              style: const TextStyle(
                  fontSize: 24,
                  color: ColorsPalette.colorlettertitle,
                  fontFamily: Global.lettertitle),
              children: <TextSpan>[
                TextSpan(
                    text: pLogin!.empresaResponse!.nombre_empresa ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: Global.lettertitle,
                        color: ColorsPalette.colorSecondary,
                        fontSize: 24)),
              ],
            ),
          ),

          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.of(Utils.globalContext.currentContext!)
                      .pushNamed(PageMenu.routePage);
                },
                child: Icon(Icons.menu_sharp,
                    size: 20, color: ColorsPalette.colorPrimary)),
            const SizedBox(
              width: 20,
            )
          ],
          toolbarHeight: 90,
          elevation: 1.0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          scrolledUnderElevation: 3.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
        ),
        backgroundColor: ColorsPalette.colorGrey,
        body: Stack(
            children: [
              GoogleMapas(),

              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(top: 100),
                      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: ColorsPalette.colorWhite,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 0.4, color: ColorsPalette.colorWhite),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.location_on_sharp, color: Colors.red, size: 20,),
                          Text("Ubicacion")
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(Utils.globalContext.currentContext!).pushNamed(PageNodos.routePage);
                      },
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.only(top: 100),
                        padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10, top: 10),
                        decoration: BoxDecoration(
                          color: ColorsPalette.colorWhite,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 0.4, color: ColorsPalette.colorWhite),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.water_drop_outlined, color: Colors.blue, size: 20,),
                            Text("Nodos")

                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),

            ],
          ),
        ),

    );
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

class GoogleMapas extends StatelessWidget {
  const GoogleMapas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(-3.9968061587874213, -79.2095810050044),
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

