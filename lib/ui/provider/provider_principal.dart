import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/domain/entities/company.dart';
import 'package:sisi_iot_app/domain/entities/device.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';
import 'package:sisi_iot_app/ui/screen/screen_login.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';

import '../screen/screen_home.dart';
import '../useful/useful.dart';
// import '../useful/useful_gps.dart';

class ProviderPrincipal extends ChangeNotifier {
  final ApiRepositoryLoginInterface? apiRepositoryLoginInterface;
  TextEditingController _editUser = TextEditingController();
  TextEditingController _editPassword = TextEditingController();
  TextEditingController _editSearchDevice = TextEditingController();
  PageController _controller = PageController(initialPage: 1);
  Company? _companyResponse = Company();
  List<Device>? _listDevice = [];
  List<Device>? listFilterDevice = [];
  String? _errorMessage;
  GoogleMapController? mapControllerExplorer;
  Map<MarkerId, Marker> _markersNodo = {};
  Map<MarkerId, Marker> _markersExplorer = {};
  final iconLocation = Completer<BitmapDescriptor>();
  int? _position = 0;
  GoogleMapController? _googleMapController;
  int? _companyWeb;
  int? _idWebDevice;
  Timer? _timer;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _currentPageIndex = 1;
  String? _version;
  bool _visiblePassword = true;

  PackageInfo? packageInfo;


  String get version => _version!;

  set version(String value) {
    _version = value;
    notifyListeners();
  }


  ProviderPrincipal(this.apiRepositoryLoginInterface) {
    Useful()
        .assetsCoverToBytes("${UsefulLabel.assetsImages}water-drop.png")
        .then((value) {
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

  int get companyWeb => _companyWeb!;

  set companyWeb(int value) {
    _companyWeb = value;
    notifyListeners();
  }

  int get idWebDevice => _idWebDevice!;

  set idWebDevice(int value) {
    _idWebDevice = value;
    notifyListeners();
  }

  Timer get timer => _timer!;

  set timer(Timer value) {
    _timer = value;
    notifyListeners();
  }

  PageController get controller => _controller;

  set controller(PageController value) {
    _controller = value;
    notifyListeners();
  }

  Map<MarkerId, Marker> get markers => _markers;

  set markers(Map<MarkerId, Marker> value) {
    _markers = value;
    notifyListeners();
  }

  int get currentPageIndex => _currentPageIndex;

  set currentPageIndex(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }

  TextEditingController get editPassword => _editPassword!;

  set editPassword(TextEditingController value) {
    _editPassword = value;
  }

  TextEditingController get editUser => _editUser!;

  set editUser(TextEditingController value) {
    _editUser = value;
  }


  TextEditingController get editSearchDevice => _editSearchDevice;

  set editSearchDevice(TextEditingController value) {
    _editSearchDevice = value;
  }

  void addVersionApp() async {
    packageInfo = await  PackageInfo.fromPlatform();
    if(Platform.isAndroid){
      version = packageInfo!.version;
    }else {
      version = packageInfo!.version;
    }
  }

  Future login(BuildContext context) async {
    if (_editUser.text.trim().isEmpty) {
      return Useful().messageAlert(context, UsefulLabel.txtEmptyUser);
    }

    if (_editPassword.text.trim().isEmpty) {
      return Useful().messageAlert(context, UsefulLabel.txtEmptyUser);
    }
    Useful().showProgress();
    await apiRepositoryLoginInterface!
        .login(_editUser.text.trim(), _editPassword.text.trim(), (code, data) {
      _companyResponse = data;
      Useful().hideProgress(context);
        if (_companyResponse!.bandera!) {
          GlobalPreference().setIdEmpresa(_companyResponse!);
          Useful().nextScreenViewUntil(const ScreenHome());
        } else {
           Useful().messageAlert(context, UsefulLabel.txtFailPassword);
        }
      return null;
    });
  }

  /// Get user bussiness
  getUser(BuildContext context) async {
    GlobalPreference().getIdEmpresa().then((idEmpresa) {
      _companyResponse = idEmpresa;
      getDevice(idEmpresa!.id_empresas!, context);
    });
  }

  /// Get nodos id bussiness
  getDevice(int id, BuildContext context) async {
    Useful().showProgress();
    await apiRepositoryLoginInterface?.getNodoId(id, (code, data) {
      Useful().hideProgress(context);
      if (code == 1) {
        listDevice = data;
        listFilterDevice = data;
        for (var element in listDevice) {
          MarkerId markerId = MarkerId(element.ide.toString());
          LatLng latLng =
              LatLng(double.parse(element.lat!), double.parse(element.lot!));
          addMarker(
            markers,
            markerId.toString(),
            latLng,
            size: 60,
          );
        }
      } else {
        listDevice = [];
      }
      return null;
    });
  }

  void addMarker(markers, String idMarker, LatLng latLng,
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
    final styleMap = styleMapGoogle();
    return jsonEncode(styleMap);
  }

  /// Filter history event
  void searchHistorialFilter(String param) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    if (param.length > 3) {
      timer = Timer(const Duration(milliseconds: 500), () {
        listFilterDevice = _listDevice!
            .where((element) =>
                element.nombre!.toLowerCase().contains(param.toLowerCase()))
            .toList();
        notifyListeners();
      });
    } else {
      timer = Timer(const Duration(milliseconds: 500), () {
        listFilterDevice = _listDevice;
        notifyListeners();
      });
    }
  }

  ///Clean text fiel search
  void cleanTextFieldSearch(BuildContext context) {
    editSearchDevice.clear();
    GlobalPreference().getIdEmpresa().then((idEmpresa)  {
      getDevice(idEmpresa!.id_empresas!, context);
    });
    notifyListeners();
  }

  ///DATE AND DATETIME NODO
  String extractDate(String dateTimeString) {
    List<String> parts = dateTimeString.split(" Hora: ");
    if (parts.length == 2) {
      return parts[0]; // Retorna la fecha
    } else {
      return "Formato incorrecto";
    }
  }

  String extractTime(String dateTimeString) {
    List<String> parts = dateTimeString.split(" Hora: ");
    if (parts.length == 2) {
      String timePart = parts[1]; // Obtiene la parte de la hora
      List<String> timeComponents =
          timePart.split(":"); // Divide la hora en partes
      if (timeComponents.length == 3) {
        String hours = timeComponents[0];
        String minutes = timeComponents[1];
        return "$hours:$minutes"; // Retorna solo horas y minutos
      } else {
        return "Formato incorrecto";
      }
    } else {
      return "Formato incorrecto";
    }
  }

  void logoOut(){
    listDevice.clear();
    listFilterDevice!.clear();
    editUser.text ="";
    editPassword.text ="";
    GlobalPreference().deleteUser();
    Useful().nextScreenViewUntil(ScreenLogin());
  }
}
