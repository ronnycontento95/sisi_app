import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisi_iot_app/domain/entities/company.dart';
import 'package:sisi_iot_app/domain/entities/device.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';
import 'package:sisi_iot_app/domain/repositories/repository_interface.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';


import '../screen/screen_home.dart';
import '../screen/screen_login.dart';
import '../useful/useful.dart';
import '../useful/useful_gps.dart';

class ProviderPrincipal extends ChangeNotifier {
  final ApiRepositoryLoginInterface? apiRepositoryLoginInterface;
  final RepositoryInterface? repositoryInterface;
  bool _visiblePassword = true;
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  TextEditingController get controllerUser => _controllerUser;
  Company? _companyResponse = Company();
  List<Device>? _listDevice = [];
  String? _errorMessage;
  GoogleMapController? mapControllerExplorer;
  Map<MarkerId, Marker> _markersNodo = {};
  Map<MarkerId, Marker> _markersExplorer = {};
  final iconLocation = Completer<BitmapDescriptor>();
  int? _position = 0;
  GoogleMapController? _googleMapController;
  Device? _companyWeb;
  int? _idWebDevice;


  ProviderPrincipal(this.apiRepositoryLoginInterface, this.repositoryInterface) {
    Useful().assetsCoverToBytes("${UsefulLabel.assetsImages}pin_origin.png").then((value) {
      final bitmap = BitmapDescriptor.fromBytes(value);
      iconLocation.complete(bitmap);
    });
    notifyListeners();
  }

  List<Device> get listDevice => _listDevice!;

  set listDevice(List<Device> value) {
    _listDevice = value;
    notifyListeners();
  }

  Company get companyResponse => _companyResponse!;

  set companyResponse(Company value) {
    _companyResponse = value;
    notifyListeners();
  }

  set controllerUser(TextEditingController value) {
    _controllerUser = value;
    notifyListeners();
  }

  TextEditingController get controllerPassword => _controllerPassword;

  set controllerPassword(TextEditingController value) {
    _controllerPassword = value;
    notifyListeners();
  }

  bool get visiblePassword => _visiblePassword;

  set visiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  String? get errorMessage => _errorMessage;

  set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  Map<MarkerId, Marker> get markersNodo => _markersNodo;

  set markersNodo(Map<MarkerId, Marker> value) {
    _markersNodo = value;
  }

  Map<MarkerId, Marker> get markersExplorer => _markersExplorer;

  set markersExplorer(Map<MarkerId, Marker> value) {
    _markersExplorer = value;
    notifyListeners();
  }

  int get position => _position!;

  set position(int value) {
    _position = value;
    notifyListeners();
  }

  GoogleMapController get googleMapController => _googleMapController!;

  set googleMapController(GoogleMapController value) {
    _googleMapController = value;
    notifyListeners();
  }

  Device get companyWeb => _companyWeb!;

  set companyWeb(Device value) {
    _companyWeb = value;
    notifyListeners();
  }


  int get idWebDevice => _idWebDevice!;

  set idWebDevice(int value) {
    _idWebDevice = value;
    notifyListeners();
  }

  Future login() async {
    await apiRepositoryLoginInterface?.login(controllerUser.text.trim(), controllerPassword.text.trim(), (code, data) {
      _companyResponse = data;
      repositoryInterface!.saveUser(_companyResponse!).then((value) {
        if (_companyResponse!.bandera!) {
          Navigator.of(Useful.globalContext.currentContext!)
              .pushNamedAndRemoveUntil(ScreenHome.routePage, (Route<dynamic> route) => false);
        } else {
          //TODO ERROR DE LOGIN
          errorMessage = "Hubo un error al iniciar sesión";
        }
      });
    });
  }

  /// Get user bussiness
  getUser() async {
    repositoryInterface!.getIdEmpresa().then((value) {
      _companyResponse = value;
      getDevice(_companyResponse!.id_empresas!);
    });
  }

  /// Get nodos id bussiness
  getDevice(int id) async {
    await apiRepositoryLoginInterface?.getNodoId(id, (code, data) {
      if (code == 1) {
        listDevice = data;
      } else {
        listDevice = [];
      }
    });
  }

  ///Get device web
  webViewDevice() {
    _idWebDevice = companyWeb.ide;
  }

  /// Sign off device
  signOff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(Useful.globalContext.currentContext!)
        .pushNamedAndRemoveUntil(ScreenLogin.routePage, (Route<dynamic> route) => false);
  }

  void initMapExplorer(GoogleMapController controller) {
    mapControllerExplorer = controller;
    addMarker(
      _markersExplorer,
      "locationMarker",
      LatLng(UsefulGps.latitude, UsefulGps.longitude),
      "${UsefulLabel.assetsIcons}pin_origin.png",
      size: 60,
    );
  }

  void addMarker(markers, String idMarker, LatLng latLng, String icon,
      {Function? function,
      String? text = "",
      int size = UsefulLabel.targetWidth,
      bool draggable = false,
      String? networkImage,
      Function(LatLng)? onDragEnd}) async {
    MarkerId markerId = MarkerId(idMarker.toString());
    markers[markerId] = Marker(
        markerId: markerId,
        position: latLng,
        zIndex: 1,
        icon: await iconLocation.future,
        rotation: 0.0,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(snippet: "", title: text),
        onDragEnd: (newPosition) {
          if (onDragEnd != null) onDragEnd(newPosition);
        },
        draggable: draggable,
        onTap: () {
          if (function != null) function();
        });
    notifyListeners();
  }

  void onCameraCenter(CameraPosition position) {
    mapControllerExplorer!.animateCamera(CameraUpdate.newCameraPosition(
      position,
    ));
  }

  styleMapGoogle() {
    return jsonEncode(styleMapGoogle);
  }
}
