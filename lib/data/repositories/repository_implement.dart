import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisi_iot_app/domain/entities/company.dart';
import 'package:sisi_iot_app/domain/repositories/repository_interface.dart';

class RepositorieImplement extends RepositoryInterface {
  static const _userEmpresa = 'userEmpresa';

  @override
  Future saveUser(Company idEmpresa) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonEncoder encoder = const JsonEncoder();
    prefs.setString(_userEmpresa, encoder.convert(idEmpresa.toMap()));
  }

  @override
  Future<Company?> getIdEmpresa() async {
    JsonDecoder decoder = const JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idEmpresa = prefs.getString(_userEmpresa) ?? "";
    if (idEmpresa.isEmpty) {
      return null;
    }
    return Company.map(decoder.convert(idEmpresa));
  }

  @override
  Future deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userEmpresa);
  }
}
