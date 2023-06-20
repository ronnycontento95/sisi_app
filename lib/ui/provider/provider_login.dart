import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisi_iot_app/domain/entities/empresa.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';
import 'package:sisi_iot_app/domain/repositories/repository_interface.dart';
import 'package:sisi_iot_app/ui/pages/page_home.dart';
import 'package:sisi_iot_app/ui/pages/page_login.dart';
import 'package:sisi_iot_app/ui/utils/style_map_google.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/global.dart';
import '../utils/global_gps.dart';

class ProviderLogin extends ChangeNotifier {
  final ApiRepositoryLoginInterface? apiRepositoryLoginInterface;
  final RepositoryInterface? repositoryInterface;
  bool _visiblePassword = true;
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController get controllerUser => _controllerUser;
  EmpresaResponse? _empresaResponse = EmpresaResponse();
  List<EmpresaNodosResponse> _empresaNodosResponse = [];
  List<EmpresaNodosResponse> get empresaNodosResponse => _empresaNodosResponse;
  String? _errorMessage;
  GoogleMapController? mapControllerExplorer;
  Map<MarkerId, Marker> _markersNodo = {};
  Map<MarkerId, Marker> _markersExplorer = {};
  final iconLocation = Completer<BitmapDescriptor>();
  int? _position = 0;
  GoogleMapController? _googleMapController;

  ///Init provider
  ProviderLogin(this.apiRepositoryLoginInterface, this.repositoryInterface) {
    Utils().assetsCoverToBytes("${Global.assetsImages}pin_origin.png").then((value) {
      final bitmap = BitmapDescriptor.fromBytes(value);
      iconLocation.complete(bitmap);
    });
    notifyListeners();
  }

  set empresaNodosResponse(List<EmpresaNodosResponse> value) {
    _empresaNodosResponse = value;
    notifyListeners();
  }

  EmpresaResponse? get empresaResponse => _empresaResponse;

  set empresaResponse(EmpresaResponse? value) {
    _empresaResponse = value;
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

  Future login() async {
    await apiRepositoryLoginInterface?.login(controllerUser.text.trim(), controllerPassword.text.trim(), (code, data) {
      empresaResponse = data;
      repositoryInterface!.saveUser(empresaResponse!).then((value) {
        if (empresaResponse!.bandera!) {
          debugPrint("RESPONSE PROVIDER ${data}");
          Navigator.of(Utils.globalContext.currentContext!)
              .pushNamedAndRemoveUntil(PageHome.routePage, (Route<dynamic> route) => false);
        } else {
          //TODO ERROR DE LOGIN
          debugPrint("RESPONSE PROVIDER LOGIN ${data}");
          errorMessage = "Hubo un error al iniciar sesión";
        }
      });
    });
  }

  /// Get user bussiness
  getUser() async {
    repositoryInterface!.getIdEmpresa().then((value) {
      empresaResponse = value;
      getNodosId(empresaResponse!.id_empresas!);
    });
  }

  //Get nodos id bussiness
  getNodosId(int id) async {
    await apiRepositoryLoginInterface?.getNodoId(id, (code, data) {
      if (code == -1) {
        empresaNodosResponse = [];
      } else {
        empresaNodosResponse = data;
      }
    });
  }

  // Sign off
  signOff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(Utils.globalContext.currentContext!)
        .pushNamedAndRemoveUntil(PageLogin.routePage, (Route<dynamic> route) => false);
  }

  // controller(){
  //   WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           // Update loading bar.
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {},
  //         onWebResourceError: (WebResourceError error) {},
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url.startsWith('https://sisi.com.ec/aplicacion/celular/nodo_individual/30/')) {
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(Uri.parse('https://sisi.com.ec/aplicacion/celular/nodo_individual/30/'));
  // }
  void initMapExplorer(GoogleMapController controller) {
    mapControllerExplorer = controller;
    addMarker(
      _markersExplorer,
      "locationMarker",
      LatLng(Gps.latitude, Gps.longitude),
      "${Global.assetsIcons}pin_origin.png",
      size: 60,
    );
  }

  void addMarker(markers, String idMarker, LatLng latLng, String icon,
      {Function? function,
      String? text = "",
      int size = Global.targetWidth,
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

  styleMapGoogle(){
    return jsonEncode(uberMapTheme);
  }
}
