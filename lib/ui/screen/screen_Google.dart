import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_style_map.dart';

class ScreenGoogle extends StatefulWidget {
  const ScreenGoogle({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routerScreenGoogle;

  @override
  State<ScreenGoogle> createState() => _ScreenGoogleState();
}

class _ScreenGoogleState extends State<ScreenGoogle> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle statusBarIconBrightness =
    Theme.of(context).brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    final pvPrincipal = context.read<ProviderPrincipal>();
    return AnnotatedRegion(
      value: statusBarIconBrightness,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-1.2394663499056315, -78.65732525997484),

            ),
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              pvPrincipal.googleMapController = controller;
              // pvPrincipal.googleMapController.setMapStyle(jsonEncode(styleMapGoogle).toString());
              // pvPrincipal.googleMapController.animateCamera(CameraUpdate.newLatLng(
              //     const LatLng(-4.009051005165443, -79.20641913069285)));
            },
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(pvPrincipal.markers.values),
          ),
        ],
      ),
    );
  }
}
