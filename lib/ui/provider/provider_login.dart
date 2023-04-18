

import 'package:flutter/cupertino.dart';
import 'package:sisi_iot_app/domain/entities/empresa.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';
import 'package:sisi_iot_app/domain/repositories/repository_interface.dart';
import 'package:sisi_iot_app/ui/pages/page_home.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

class ProviderLogin extends ChangeNotifier{
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

  //TODO CARGAR DATOS DEL USUARIO
  getUser () async {
      repositoryInterface!.getIdEmpresa().then((value){
        empresaResponse =value;
        getNodosId(empresaResponse!.id_empresas!);
    });
  }

  //LOGIN
  Future login () async {
    await apiRepositoryLoginInterface?.login(controllerUser.text.trim(), controllerPassword.text.trim(), (code, data) {
      empresaResponse =data;
      repositoryInterface!.saveUser(empresaResponse!).then((value){
        if(empresaResponse!.bandera!){
          Navigator.of(Utils.globalContext.currentContext!).pushNamedAndRemoveUntil(PageHome.routePage, (Route<dynamic> route) => false);
        }else {
          //TODO ERROR DE LOGIN
          debugPrint("RESPONSE PROVIDER LOGIN ${data}");
        }
      });
    });
  }

  getNodosId(int id) async {
    await apiRepositoryLoginInterface?.getNodoId(id, (code, data) {
      print("Estoy presnete aqui nodos");
      if(code == -1){
        empresaNodosResponse =[];
      }else {
        empresaNodosResponse =data;
      }
      print("Estoy ${data}");
    });
  }
}