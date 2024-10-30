import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/domain/entities/model_business.dart';
import 'package:sisi_iot_app/domain/entities/dataDevice.dart';
import 'package:sisi_iot_app/domain/entities/datos_diccionario.dart';
import 'package:sisi_iot_app/domain/entities/device.dart';
import 'package:sisi_iot_app/domain/entities/model_diccionario_nodo.dart';
import 'package:sisi_iot_app/domain/entities/model_list_nodos.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';
import 'package:sisi_iot_app/ui/screen/screen_Google.dart';
import 'package:sisi_iot_app/ui/screen/screen_card_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_chart_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_detail_nodo.dart';
import 'package:sisi_iot_app/ui/screen/screen_detail_diccionario.dart';
import 'package:sisi_iot_app/ui/screen/screen_login.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';
import 'package:sisi_iot_app/ui/widgets/widget_custom_bottom_sheet.dart';
import 'package:sisi_iot_app/ui/screen/screen_profile.dart';

import '../screen/screen_home.dart';
import '../useful/useful.dart';

class ProviderPrincipal extends ChangeNotifier {
  final ApiRepositoryLoginInterface? apiRepositoryLoginInterface;
  TextEditingController _editUser = TextEditingController();
  TextEditingController _editPassword = TextEditingController();
  TextEditingController _editSearchDevice = TextEditingController();
  PageController _controller = PageController(initialPage: 1);
  Company? _companyResponse = Company();
  DatosDiccionario? _datosDiccionario;
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
  Timer? _timerDevice;
  ModelDiccionarioNodo? _modelDiccionarioNodo;
  ModelListNodos? _modelListNodos = ModelListNodos();
  int _pageScreen = 0;


  int get pageScreen => _pageScreen;

  set pageScreen(int value) {
    _pageScreen = value;
    notifyListeners();
  }

  ModelListNodos? get modelListNodos => _modelListNodos;

  set modelListNodos(ModelListNodos? value) {
    _modelListNodos = value;
    notifyListeners();
  }

  ModelDiccionarioNodo? get modelDiccionarioNodo => _modelDiccionarioNodo;

  set modelDiccionarioNodo(ModelDiccionarioNodo? value) {
    _modelDiccionarioNodo = value;
    notifyListeners();
  }

  DatosDiccionario? get datosDiccionario => _datosDiccionario;

  set datosDiccionario(DatosDiccionario? value) {
    _datosDiccionario = value;
    notifyListeners();
  }

  Timer get timerDevice => _timerDevice!;

  set timerDevice(Timer value) {
    _timerDevice = value;
  }

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
    packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      version = packageInfo!.version;
    } else {
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

  List<Widget> itemScreen = [
    const ScreenChartNodos(),
    const ScreenCardNodos(),
    const ScreenGoogle(),
    const ScreenProfile(),
  ];

  List<TabItem> items = [
    const TabItem(icon: Icons.home, title: 'Home'),
    const TabItem(icon: Icons.push_pin, title: 'Tarjetas'),
    const TabItem(icon: Icons.public, title: 'Mapa'),
    const TabItem(icon: Icons.account_box, title: 'Perfil'),
  ];

  /// Get user bussiness
  Future<void> getUser(BuildContext context) async {
    GlobalPreference().getIdEmpresa().then((idEmpresa) {
      companyResponse = idEmpresa!;
      getDevice(idEmpresa.id_empresas!, context);
      // getDeviceTimer(idEmpresa.id_empresas!, context);
    });
  }

  /// Get nodos id bussiness
  getDevice(int id, BuildContext context) async {
    Useful().showProgress();
    await apiRepositoryLoginInterface?.getListNodo(id, (code, data) {
      Useful().hideProgress(context);
      if (code == 1) {
        modelListNodos = data;
        // for (var element in listDevice) {
        //   MarkerId markerId = MarkerId(element.ide.toString());
        //   LatLng latLng = LatLng(double.parse(element.lat!), double.parse(element.lot!));
        //   addMarker(
        //     markers,
        //     markerId.toString(),
        //     latLng,
        //     size: 60,
        //   );
        // }
      } else {}
      return null;
    });
    // });
  }

  /// Get nodos id bussiness
  getDeviceTimer(int id, BuildContext context) async {
    _timerDevice = Timer.periodic(const Duration(minutes: 1), (timer) async {
      // Useful().showProgress();
      await apiRepositoryLoginInterface?.getBusinessNodo(id, (code, data) {
        Useful().hideProgress(context);
        if (code == 1) {
          // for (var element in listDevice) {
          //   MarkerId markerId = MarkerId(element.ide.toString());
          //   LatLng latLng =
          //       LatLng(double.parse(element.lat!), double.parse(element.lot!));
          //   addMarker(
          //     markers,
          //     markerId.toString(),
          //     latLng,
          //     size: 60,
          //   );
          // }
        } else {
          // listDevice = [];
        }
        return null;
      });
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
    // if (param.length > 3) {
    //   listFilterDevice = listDevice!.where((element) => element.data.!.toLowerCase().contains(param.toLowerCase())).toList();
    //   notifyListeners();
    // } else {
    //   listFilterDevice = listDevice;
    //   notifyListeners();
    // }
  }

  ///Clean text fiel search
  void cleanTextFieldSearch(BuildContext context) {
    editSearchDevice.clear();
    GlobalPreference().getIdEmpresa().then((idEmpresa) {
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
      List<String> timeComponents = timePart.split(":"); // Divide la hora en partes
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

  void logoOut() {
    editUser.text = "";
    editPassword.text = "";
    GlobalPreference().deleteUser();
    Useful().nextScreenViewUntil(ScreenLogin());
  }

  showBottomSheet(BuildContext context) {
    // customBottomSheet(context, widget: const ScreenMenuNavbar());
  }

  void getDataDeviceId(int id, BuildContext context) {
    Useful().showProgress();
    apiRepositoryLoginInterface?.getDataDeviceId(id, (code, data) {
      Useful().hideProgress(context);
      if (data != null) {
        datosDiccionario = data;
        Navigator.of(context).pushNamed(
          ScreenDetailNodo.routePage,
        );
      }
      return null;
    });
  }

  Icon getIconByIdentifier(int identificador) {
    switch (identificador) {
      case 201:
        return const Icon(FontAwesomeIcons.batteryFull, color: Colors.green); // Batería
      case 202:
        return const Icon(FontAwesomeIcons.tint, color: Colors.green); // Porcentaje de agua

      case 203:
        return const Icon(FontAwesomeIcons.glassWhiskey, color: Colors.green); // Valumen

      case 204:
        return const Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.green); // Batería

      case 205:
      case 206:
        return Icon(FontAwesomeIcons.fillDrip, color: Colors.orange); // Porcentaje

      case 207:
      case 208:
      case 209:
      case 210:
      case 211:
      case 212:
        return Icon(Icons.waves, color: Colors.blue); // Nivel

      case 245:
        return const Icon(FontAwesomeIcons.solidCircle, color: Colors.green); // Presión

      case 213:
      case 214:
      case 215:
      case 216:
      case 217:
      case 218:
      case 219:
      case 220:
      case 221:
      case 222:
      case 223:
      case 224:
      case 225:
      case 226:
      case 227:
      case 228:
      case 229:
      case 230:
      case 231:
      case 232:
      case 233:
      case 234:
      case 235:
      case 236:
      case 237:
      case 238:
      case 239:
      case 240:
      case 241:
      case 242:
      case 243:
      case 244:
        return const Icon(FontAwesomeIcons.toolbox, color: Colors.grey); // Medidor
      case 246:
        return const Icon(FontAwesomeIcons.solidCircle, color: Colors.green); // Medidor
      case 247:
        return const Icon(FontAwesomeIcons.solidCircle, color: Colors.green); // Medidor

      case 208:
      case 209:
        return const Icon(Icons.settings, color: Colors.blue); // Control

      case 249:
      case 250:
      case 251:
      case 252:
        return const Icon(FontAwesomeIcons.water, color: Colors.blueAccent); // Volumen

      case 251:
      case 204:
        return Icon(Icons.warning, color: Colors.red); // Desborde / Alarma

      default:
        return Icon(Icons.device_unknown, color: Colors.grey); // Icono por defecto
    }
  }

  typeImagen() async {
    GlobalPreference().getIdEmpresa().then((idEmpresa) {});
  }

  void getDataDiccionarioIdNodoId(
      String idNodo, int idDiccionario, BuildContext context) {
    Useful().showProgress();
    apiRepositoryLoginInterface?.getDataDiccionarioIdNodoID(idNodo, idDiccionario,
        (code, data) {
      Useful().hideProgress(context);
      if (data != null) {
        modelDiccionarioNodo = data;

        Navigator.of(context).pushNamed(
          ScreenDetailDiccionario.routePage,
        );
      }

      return null;
    });
  }

  buildBottomBar(BuildContext context) {
    return BottomBarDefault(
      items: items,
      backgroundColor: Colors.white,
      color: Colors.black38,
      colorSelected: UsefulColor.colorPrimary,
      indexSelected: pageScreen,
      // isFloating: true,
      onTap: (int index) {
        pageScreen = index;
      },
    );
  }

}
