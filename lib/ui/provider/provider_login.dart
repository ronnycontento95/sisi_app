
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
import 'package:sisi_iot_app/ui/utils/utils.dart';

class ProviderLogin extends ChangeNotifier {
  final ApiRepositoryLoginInterface? apiRepositoryLoginInterface;
  final RepositoryInterface? repositoryInterface;

  ProviderLogin(this.apiRepositoryLoginInterface, this.repositoryInterface);

  bool _visiblePassword = true;
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController get controllerUser => _controllerUser;
  EmpresaResponse? _empresaResponse = EmpresaResponse();
  List<EmpresaNodosResponse> _empresaNodosResponse = [];
  List<EmpresaNodosResponse> get empresaNodosResponse => _empresaNodosResponse;
  String? _errorMessage;


  Map<MarkerId, Marker> _markersNodo = {};

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

  //Login
  Future login() async {
    await apiRepositoryLoginInterface?.login(controllerUser.text.trim(), controllerPassword.text.trim(), (code, data) {
      empresaResponse = data;
      repositoryInterface!.saveUser(empresaResponse!).then((value) {
        if (empresaResponse!.bandera!) {
          debugPrint("RESPONSE PROVIDER ${data}");
          Navigator.of(Utils.globalContext.currentContext!).pushNamedAndRemoveUntil(PageHome.routePage, (Route<dynamic> route) => false);
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
      print('Empresa provider >>> ${empresaResponse}');
      getNodosId(empresaResponse!.id_empresas!);
    });
  }

  //Get nodos id bussiness
  getNodosId(int id) async {
    await apiRepositoryLoginInterface?.getNodoId(id, (code, data) {
      if(code == -1){
        empresaNodosResponse =[];
      }else {
        print('>>>>EMPRESA NODOS RESPONSE ${empresaNodosResponse}');
        empresaNodosResponse =data;
      }
    });
  }

  // Sign off
  signOff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(Utils.globalContext.currentContext!).pushNamedAndRemoveUntil(PageLogin.routePage, (Route<dynamic> route) => false);
  }
}
