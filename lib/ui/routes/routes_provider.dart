
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sisi_iot_app/data/repositories/api_repository_login_implement.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider(create: (_)=> ProviderPrincipal(ApiRepositorieLoginImplement(), RepositorieImplement()))
  ];

}