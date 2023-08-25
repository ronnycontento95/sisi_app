import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisi_iot_app/domain/entities/company.dart';

class GlobalPreference {
  static const _userEmpresa = 'userEmpresa';

  Future setSaveUser(Company idEmpresa) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonEncoder encoder = const JsonEncoder();
    prefs.setString(_userEmpresa, encoder.convert(idEmpresa.toMap()));
  }

  Future<Company?> getIdEmpresa() async {
    JsonDecoder decoder = const JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idEmpresa = prefs.getString(_userEmpresa) ?? "";
    if (idEmpresa.isEmpty) {
      return null;
    }
    return Company.map(decoder.convert(idEmpresa));
  }

  Future deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userEmpresa);
  }
}
