import 'package:sisi_iot_app/domain/entities/empresa.dart';

abstract class RepositoryInterface {
   Future saveUser(EmpresaResponse idEmpresa);
   Future<EmpresaResponse?> getIdEmpresa();
   Future deleteUser();


}