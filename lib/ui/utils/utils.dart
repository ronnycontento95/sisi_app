import 'dart:io';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Utils {
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

  /// Init conectivity
  InitConectivity(Connectivity connectivity) async {
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

  updateConectivity(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        checkConnection().then((value) {
          if (!value) {
            // Navigator.push(
            //   Utils.globalContext!.currentContext!,
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
            //   Utils.globalContext!.currentContext!,
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
      //   Utils.globalContext!.currentContext!,
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
