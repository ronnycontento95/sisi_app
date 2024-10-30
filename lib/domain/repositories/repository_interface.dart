import 'package:sisi_iot_app/domain/entities/model_business.dart';

abstract class RepositoryInterface {
   Future saveUser(Company idEmpresa);
   Future<Company?> getIdEmpresa();
   Future deleteUser();
}