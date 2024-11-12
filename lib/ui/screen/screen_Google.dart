import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';


import '../../config/global_url.dart';

class ScreenGoogle extends StatelessWidget {
  const ScreenGoogle({Key? key}) : super(key: key);
  static const routePage = CommonLabel.routerScreenGoogle;

  @override
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
        Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: const Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [CustomMap(), ListCardNodos()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCardNodos extends StatefulWidget {
  const ListCardNodos({super.key});

  @override
  State<ListCardNodos> createState() => _ListCardNodosState();
}

class _ListCardNodosState extends State<ListCardNodos> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderPrincipal>().createMarkerMapNodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    if (pvPrincipal.modelListNodos?.nodos?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }



    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 120,
        child: Swiper(
          onTap: (v){
            pvPrincipal.getDataDeviceId(pvPrincipal.modelListNodos!.nodos![v].idNodos! , context);
          },
          viewportFraction: 0.85,
          itemCount: pvPrincipal.modelListNodos!.nodos!.length,
          loop: false,
          onIndexChanged: (index) {
            var item = pvPrincipal.modelListNodos!.nodos![index];
            pvPrincipal.selectNodoToMap(item);
          },
          itemBuilder: (context, index) {
            var item = pvPrincipal.modelListNodos!.nodos![index];
            final Color color = item.valor! >= item.valorMaximo!
                ? Colors.redAccent
                : item.valor! <= item.valorMinimo!
                ? Colors.orangeAccent
                : CommonColor.colorPrimary;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              color: Colors.white,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          pvPrincipal.modelListNodos!.idEmpresa == '2'
                              ? 'assets/images/glp.svg':'assets/images/tank.svg',
                          width: 60,
                          height: 60,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.nombrePresentar ?? "S/n",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${item.valor}" ?? "S/n",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomMap extends StatelessWidget {
  const CustomMap({super.key});

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(
            pvPrincipal.currentPosition!.latitude,
            pvPrincipal.currentPosition!.longitude,
          ),
          zoom: 13),
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,

      onMapCreated: (controller) {
        pvPrincipal.googleMapController = controller;
      },
      markers: Set<Marker>.of(pvPrincipal.markers.values),
    );
  }
}
