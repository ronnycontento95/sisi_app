
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:sisi_iot_app/data/repositories/api_global_url.dart';
import 'package:sisi_iot_app/data/repositories/dio_exceptions.dart';
import 'package:sisi_iot_app/domain/entities/empresa.dart';
import 'package:sisi_iot_app/domain/entities/empresaNodos.dart';
import 'package:sisi_iot_app/domain/repositories/api_repository_login_interface.dart';

class ApiRepositorieLoginImplement implements ApiRepositoryLoginInterface {
  // Dio dio = Dio(BaseOptions(
  //   baseUrl: ApiGlobalUrl.GENERAL_LINK,
  //   connectTimeout: 15000,//tiempo de espera de conexión
  //   receiveTimeout: 15000, //recibirTiempo de espera
  //   // headers: {"Authorization": "Bearer ${Global.token}",}
  // ));
  Dio dio = Dio();

  @override
  Future login(String username, String password, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response = await dio.get("${ApiGlobalUrl.GENERAL_LINK}${ApiGlobalUrl.GET_LOGIN}${username}/${password}");
      print ('logion response>>>> "${ApiGlobalUrl.GENERAL_LINK}${ApiGlobalUrl.GET_LOGIN}${username}/${password}');
      print ('logion response>>>> $response');
      callback(1, EmpresaResponse.fromMap(response.data));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print("Eroor${errorMessage}");
      callback(-1, EmpresaResponse(bandera: false));
    }
  }

  @override
  Future getNodoId(int id, VoidCallback? Function(int code, dynamic data) callback) async {
    try {
      final response = await dio.get("${ApiGlobalUrl.GENERAL_LINK}${ApiGlobalUrl.GET_NODOS_ID}${id}");
      print('RESPONSE GET NODOS ID>>>>${response.data[0]}');

      // response.data((c) => print('?>>>>>>>>>>>${c}')).toList();
      // print('List ${list}');
      // list?.forEach((element) {
      //   print('RESPONSE Nodo>>>>${element}');
      //
      // });

      List<EmpresaNodosResponse> _empresaNodoResponse = [];
      if(response.data!=null){
        List<dynamic> listNodo = response.data;
        print('>>>>${listNodo}');
        listNodo.forEach((element) {
          print('<<<<>>>>>>>>>${element}');
          _empresaNodoResponse.add(EmpresaNodosResponse.fromMap(element));
        });
        callback(1, _empresaNodoResponse);
      }else{
        callback(-1, "No existe datos");
      }

    }on DioError catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      callback(-1, "Error de lista de nodos");
    }
  }
}