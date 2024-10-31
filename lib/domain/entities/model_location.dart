
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationStatus {
  success,
  disabled, //if gps off
  denied, //if permissions denied
  failed, //any error execution
  timeout, //error timeout when get location
  aproximate, //aproximate
}


class ModelLocation {
  LocationStatus status;
  Position? position;

  LatLng? get latLng =>
      position != null ? LatLng(position!.latitude, position!.longitude) : null;

  ModelLocation(this.status, this.position);
}
