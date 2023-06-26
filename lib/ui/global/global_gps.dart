import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:permission_handler/permission_handler.dart' as permiso;


class Gps {
  static double? _latitude = 0.0;
  static double? _longitude = 0.0;
  static Position? _position;
  static StreamSubscription<Position>? positionStream;

  static double get latitude => _latitude!;

  static set latitude(double value) {
    _latitude = value;
  }

  static double get longitude => _longitude!;

  static set longitude(double value) {
    _longitude = value;
  }

  static Position get position => _position!;

  static set position(Position value) {
    _position = value;
  }

  final geolocator.GeolocatorPlatform _geolocatorPlatform = geolocator.GeolocatorPlatform.instance;

  Future checkGPS() async {
    final status = await permiso.Permission.locationWhenInUse.request();
    if (status == permiso.PermissionStatus.granted) {
      //final locationServiceEnabled = await location.serviceEnabled();
      final locationServiceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      if (locationServiceEnabled) {
        positionNow();
        return true;
      } else {
       // location.requestService().then((value) {
        _geolocatorPlatform.requestPermission().then((value) {
          if (value==LocationPermission.always || value==LocationPermission.whileInUse) {
            positionNow();
            return true;
          } else {
            positionNow();
            return false;
          }
        });
      }
    } else {
      permiso.openAppSettings();
      return false;
    }
  }

  positionNow({ValueChanged<Position?>? positionBackgroud}) async {
    positionStream?.cancel();
    positionStream = Geolocator.getPositionStream().listen((position) {
      positionNew(position);
      if (positionBackgroud != null) positionBackgroud(position);
    }, onError: (err) {
      checkGPS();
    });
  }

  positionNew(Position position) {
    latitude = position.latitude;
    longitude = position.longitude;
    position = position;
  }
}
