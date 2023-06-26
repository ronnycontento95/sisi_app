
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/data/repositories/dio_exceptions.dart';
import 'package:sisi_iot_app/domain/entities/company.dart';
import 'package:sisi_iot_app/domain/entities/device.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';

class ApiRepositorieLoginImplement implements ApiRepositoryLoginInterface {
  // Dio dio = Dio(BaseOptions(
  //   baseUrl: ApiGlobalUrl.generalLink,
  //   connectTimeout: 15000,//tiempo de espera de conexión
  //   receiveTimeout: 15000, //recibirTiempo de espera
  //   // headers: {"Authorization": "Bearer ${Global.token}",}
  // ));
  Dio dio = Dio();

  @override
  Future login(String username, String password, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response = await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getLogin}${username}/${password}");
      callback(1, Company.fromMap(response.data));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, Company(bandera: false));
    }
  }

  @override
  Future getNodoId(int id, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response = await dio.get("${ApiGlobalUrl.generalLink}${ApiGlobalUrl.getNodosId}${id}");
      List<Device> empresaNodoResponse = [];
      if(response.data!=null){
        List<dynamic> listNodo = response.data;
        for (var element in listNodo) {
          empresaNodoResponse.add(Device.fromMap(element));
        }
        callback(1, empresaNodoResponse);
      }else{
        callback(-1, "No existe datos");
      }

    }on DioError catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, errorMessage);
    }
  }
}