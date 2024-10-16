import 'dart:io';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';

import '../widgets/widget_progress.dart';
import 'useful_palette.dart';

///Utilidades widgets
/// Useful metodos
class Useful {
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  /// Cover to bytes imagen
  Future<Uint8List> assetsCoverToBytes(String path, {int width = 60}) async {
    final byteData = await rootBundle.load(path);
    final byte = byteData.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(byte, targetWidth: width);
    final frame = await codec.getNextFrame();
    final newByteData = await frame.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return newByteData!.buffer.asUint8List();
  }

  /// Init connectivity
  initConnectivity(Connectivity connectivity) async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return updateConectivity(result);
  }

  /// Show message alter
  void messageAlert(BuildContext context, String message) {
    final snackBar = SnackBar(
        backgroundColor: UsefulColor.colorPrimary,
        content: Text(message,
            style: const TextStyle(
                fontFamily: UsefulLabel.letterWalkwayBold,
                fontSize: 14,
                color: UsefulColor.colorWhite),
            textAlign: TextAlign.center));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  messageErrorScaffold(BuildContext context, String message) {
    final snackBar = SnackBar(
        backgroundColor: UsefulColor.colorPrimary,
        content: Text(message,
            style: const TextStyle(
                fontFamily: UsefulLabel.letterWalkwayBold,
                fontSize: 14,
                color: UsefulColor.colorWhite),
            textAlign: TextAlign.center));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show wait progress
  void showProgress() {
    nextScreenViewTransition(const WidgetProgress());
  }

  /// Hide wait progress
  hideProgress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void nextScreenViewTransition(Widget newPage) {
    Navigator.push(
        Useful.globalContext.currentContext!,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 1),
            reverseDuration: const Duration(milliseconds: 1),
            child: newPage));
  }

  void nextScreenViewUntil(Widget newPage) {
    Navigator.of(Useful.globalContext.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => newPage),
        (Route<dynamic> route) => false);
  }

  updateConectivity(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        checkConnection().then((value) {
          if (!value) {
            // Navigator.push(
            //   Useful.globalContext!.currentContext!,
            //   CustomPageRoute(
            //       builder: (context) => const PageDisconnectedService()),
            // );
          }
        });
        break;
      case ConnectivityResult.mobile:
        checkConnection().then((value) {
          if (!value) {
            // Navigator.push(
            //   Useful.globalContext!.currentContext!,
            //   CustomPageRoute(
            //       builder: (context) => const PageDisconnectedService()),
            // );
          }
        });
        break;

      /// reporte de pirata vista
      ///
      case ConnectivityResult.none:
        // Navigator.push(
        //   Useful.globalContext!.currentContext!,
        //   CustomPageRoute(
        //       builder: (context) => const PageDisconnectedService()),
        // );
        break;
      default:
        break;
    }
  }

  Future checkConnection() async {
    bool state = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty) {
        state = false;
      } else {
        state = true;
      }
    } on SocketException catch (_) {
      state = false;
    }
    return state;
  }
}

class UsefulImagen {
  Uint8List getTransparentImage() {
    return Uint8List.fromList(<int>[
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
}
