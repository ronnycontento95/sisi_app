import 'dart:ui';

abstract class ApiRepositoryLoginInterface {
  Future login(String username, String password,
      VoidCallback? Function(int code, dynamic data) callback);

  Future getListNodo(int id, VoidCallback? Function(int code, dynamic data) callback);

  Future getDataDeviceId(int id, VoidCallback? Function(int code, dynamic data) callback);

  Future getGraficas(int id, VoidCallback? Function(int code, dynamic data) callback);

  Future getDataDiccionarioIdNodoID(String idNodo, int idDiccionario,
      VoidCallback? Function(int code, dynamic data) callback);
}
