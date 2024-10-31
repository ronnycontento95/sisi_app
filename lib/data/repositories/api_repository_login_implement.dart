import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/data/repositories/dio_exceptions.dart';
import 'package:sisi_iot_app/domain/entities/model_business.dart';
import 'package:sisi_iot_app/domain/entities/model_nodos_diccionario.dart';
import 'package:sisi_iot_app/domain/entities/device.dart';
import 'package:sisi_iot_app/domain/entities/model_diccionario_nodo.dart';
import 'package:sisi_iot_app/domain/entities/model_list_nodos.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';

class ApiRepositorieLoginImplement implements ApiRepositoryLoginInterface {
  Dio dio = Dio();

  @override
  Future login(String username, String password,
      VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response = await dio
          .get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getLogin}$username/$password");
      if (kDebugMode) {
        log(
            "url >>> ${"${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getLogin}$username/$password"}");
        log("RESPONDE LOGIN $response");
      }
      callback(1, Company.fromMap(response.data));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (kDebugMode) {
        print(
            "ERROR >>> DioError: ${e.type}, Message: ${e.message}, Response: ${e.response} --> ${errorMessage}");
      }
      callback(-1, Company(bandera: false));
    }
  }
  @override
  Future getListNodo(
      int id, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response =
      await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getListNodo}$id");
      if (kDebugMode) {
        log("url : ${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getListNodo}$id");
        log("RESPONDE >>> LIST NDOOS $response");
      }
      if (response.data != null) {
        callback(1, ModelListNodos.fromMap(response.data));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, errorMessage);
    }
  }


  @override
  Future getBusinessNodo(
      int id, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response =
          await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getBusinessNodo}$id");
      if (kDebugMode) {
        log("url : ${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getBusinessNodo}$id");
        log("RESPONDE DATA NODOS ID $response");
      }
      if (response.data != null) {
        callback(1, ModelBusinessNodo.fromMap(response.data));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, errorMessage);
    }
  }

  @override
  Future getDataDeviceId(
      int id, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response =
          await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getDataDeviceId}$id");
      if (kDebugMode) {
        log("url : ${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getDataDeviceId}$id");
        log("RESPONDE DATA NODOS ID $response");
      }
      if (response.data != null) {
        callback(1, ModelNodosDiccionario.fromMap(response.data));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, errorMessage);
    }
  }

  @override
  Future getDataDiccionarioIdNodoID(
      String idNodo, int idDiccionario, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response =
          await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getDataDiccionarioNodo}$idNodo/$idDiccionario");
      if (kDebugMode) {
        log("url : ${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getDataDiccionarioNodo}$idNodo/$idDiccionario");
        log("RESPONDE DATA NODOS ID $response");
      }
      if (response.data != null) {
        callback(1, ModelDiccionarioNodo.fromMap(response.data));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, errorMessage);
    }
  }
}
