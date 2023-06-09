import 'dart:ui';

abstract class ApiRepositoryLoginInterface {
  Future login(String username, String password, VoidCallback? Function(int code, dynamic data) callback);
  Future getNodoId(int id, VoidCallback? Function(int code, dynamic data) callback);
}
