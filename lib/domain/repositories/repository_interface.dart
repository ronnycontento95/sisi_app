import 'package:sisi_iot_app/domain/entities/company.dart';

abstract class RepositoryInterface {
   Future saveUser(Company idEmpresa);
   Future<Company?> getIdEmpresa();
   Future deleteUser();
}