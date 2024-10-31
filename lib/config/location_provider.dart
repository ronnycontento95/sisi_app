import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:sisi_iot_app/domain/entities/model_location.dart';
// import 'package:widgets/constants/enums.dart';
// import 'package:widgets/src/common/utils.dart';
// import 'package:widgets/src/widgets/custom_map/models/location_model.dart';

class LocationProvider {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  static final LocationProvider _instance = LocationProvider._internal();

  LocationProvider._internal();

  factory LocationProvider() {
    return _instance;
  }

  //For permissions
  bool serviceEnabled = false;
  LocationPermission? permission;

  //If location requested
  bool locationRequested = false;

  Position? lastPosition;
  Position? position;

  StreamSubscription? positionStream;
  bool locationUpdatesObtain = false;
  int contToForceLocationManager = 0;

  final StreamController<Position> _positionNotificationStream =
  StreamController<Position>.broadcast();

  Stream<Position> get notifications => _positionNotificationStream.stream;

  loc.Location location = loc.Location();

  bool requesting = false;

  /// Devuelve la localización en [voidCallback] y tomar en cuenta el campo [status]
  Future<ModelLocation> initLocationService(
      {bool estimatedPosition = false,
        bool forceLocationManager = false,
        int timeoutTime = 30}) async {
    try {
      late LocationSettings locationSettings;
      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          forceLocationManager: forceLocationManager,
          intervalDuration: const Duration(seconds: 1),
        );
      } else if (Platform.isIOS || Platform.isMacOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return ModelLocation(LocationStatus.disabled, null);
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.deniedForever) {
        return ModelLocation(LocationStatus.denied, null);
      }
      locationRequested = true;

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return ModelLocation(LocationStatus.denied, null);
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        if (estimatedPosition) {
          lastPosition = await geolocatorPlatform
              .getLastKnownPosition()
              .timeout(const Duration(seconds: 5), onTimeout: () => null);
          if (lastPosition != null) {
            //init listening location
            initPositionUpdates();
            position = lastPosition;
            return ModelLocation(LocationStatus.success, lastPosition);
          } else {
            position = await geolocatorPlatform
                .getCurrentPosition(locationSettings: locationSettings)
                .catchError((onError) {
              log("Error location $onError");
              return Position.fromMap({
                "latitude": 0.0,
                "longitude": 0.0,
                "timestamp": DateTime.now().microsecondsSinceEpoch
              });
            });
            if (position?.latitude == 0.0 && position?.longitude == 0.0) {
              return ModelLocation(LocationStatus.failed, lastPosition);
            }
            lastPosition = position;
            initPositionUpdates();
            return ModelLocation(LocationStatus.success, position);
          }
        } else {
          bool timeout = false;
          bool aproximate = false;

          position = await geolocatorPlatform
              .getCurrentPosition(locationSettings: locationSettings)
              .timeout(Duration(seconds: timeoutTime), onTimeout: () async {
            final positionLats = await geolocatorPlatform
                .getLastKnownPosition()
                .timeout(const Duration(seconds: 5), onTimeout: () {
              timeout = true;
              return null;
            });
            if (positionLats != null) {
              aproximate = true;
              return positionLats;
            }
            return Position(
              longitude: 0,
              latitude: 0,
              timestamp: DateTime.now(),
              accuracy: 0,
              altitude: 0,
              altitudeAccuracy: 0,
              heading: 0,
              headingAccuracy: 0,
              speed: 0,
              speedAccuracy: 0,
            );
          });
          if (position != null &&
              (position!.latitude != 0 && position!.longitude != 0)) {
            lastPosition = position;
            initPositionUpdates();
            if (aproximate) {
              return ModelLocation(LocationStatus.aproximate, position);
            }
            return ModelLocation(LocationStatus.success, position);
          }
          if (timeout) {
            return ModelLocation(LocationStatus.timeout, position);
          }
        }
      } else {
        return ModelLocation(LocationStatus.denied, null);
      }
    } on Exception catch (_) {
      return ModelLocation(LocationStatus.failed, null);
    }
    return ModelLocation(LocationStatus.failed, null);
  }

  Future<bool> verifyPermissionInBackground() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.always;
  }

  Future<bool> requestPermissionInBackground() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.always;
  }

  Future<bool> enableService() async {
    return await location.requestService();
  }

  void initPositionUpdates() {
    _initializeListenLocationUpdates();
    geolocatorPlatform.getServiceStatusStream().listen((event) {
      if (event == ServiceStatus.disabled) {
        positionStream?.cancel();
        positionStream = null;
      } else {
        _initializeListenLocationUpdates();
      }
    });
  }

  Future<double?> getAccuracy(
      {int timeOut = 20, bool requiredEnabledGps = true}) async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!requiredEnabledGps) return null;

        serviceEnabled = await Geolocator.openLocationSettings();
        if (!serviceEnabled) {
          return null;
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        }
      }

      Position locationDataAux = await Geolocator.getCurrentPosition();
      return locationDataAux.accuracy;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<bool> isGpsActivated() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  void _initializeListenLocationUpdates({bool forceLocationManager = false}) {
    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        forceLocationManager: forceLocationManager,
        intervalDuration: const Duration(seconds: 1),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    if (positionStream != null) return;

    positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings)
        .handleError((error) async {
      log('Error handleError $error');
      positionStream?.cancel();
      positionStream = null;
      locationUpdatesObtain = false;

      await verifyLocationStatus();

      if(serviceEnabled){
        Future.delayed(
          const Duration(seconds: 1),
              () => _initializeListenLocationUpdates(forceLocationManager: true),
        );
      }
    }).listen((Position? position) {
      if (position != null) {
        locationUpdatesObtain = true;
        _positionNotificationStream.add(position);
        this.position = position;
      }
    })
      ..onError((error) async {
        log('Error stream $error');
        positionStream?.cancel();
        positionStream = null;
        locationUpdatesObtain = false;

        await verifyLocationStatus();

        if(serviceEnabled){
          Future.delayed(
            const Duration(seconds: 1),
                () => _initializeListenLocationUpdates(forceLocationManager: true),
          );
        }
      });

    Future.delayed(
      const Duration(seconds: 5),
          () async {
        if (!locationUpdatesObtain) {
          contToForceLocationManager = contToForceLocationManager >= 2
              ? contToForceLocationManager
              : contToForceLocationManager + 1;
          try {
            positionStream?.cancel();
            positionStream = null;
            late LocationSettings locationSettings;
            if (Platform.isAndroid) {
              locationSettings = AndroidSettings(
                accuracy: LocationAccuracy.high,
                forceLocationManager: true,
                intervalDuration: const Duration(seconds: 1),
              );
            } else if (Platform.isIOS || Platform.isMacOS) {
              locationSettings = AppleSettings(
                accuracy: LocationAccuracy.high,
              );
            } else {
              locationSettings = const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 100,
              );
            }
            var position = await geolocatorPlatform.getCurrentPosition(
              locationSettings: locationSettings,
            );
            _positionNotificationStream.add(position);
            _initializeListenLocationUpdates(
                forceLocationManager: contToForceLocationManager >= 2);
          } on Exception catch (e) {
            log("Error location $e");
            await verifyLocationStatus();

            if(serviceEnabled){
              _initializeListenLocationUpdates(forceLocationManager: true);
            }
          }
        }
      },
    );
  }

  Future<ModelLocation> verifyLocationStatus() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return ModelLocation(LocationStatus.disabled, null);
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return ModelLocation(LocationStatus.denied, null);
      }
      initPositionUpdates();
      return ModelLocation(LocationStatus.success, null);
    } on Exception catch (_) {
      return ModelLocation(LocationStatus.failed, null);
    }
  }
}
