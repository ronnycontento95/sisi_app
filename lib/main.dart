import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/ui/pages/page_home.dart';
import 'package:sisi_iot_app/ui/pages/page_login.dart';
import 'package:sisi_iot_app/ui/pages/page_onboarding.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/routes/routes_pages.dart';
import 'package:sisi_iot_app/ui/routes/routes_provider.dart';
import 'package:sisi_iot_app/ui/utils/global_color.dart';
import 'package:sisi_iot_app/ui/utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();//Inicialice metodos en el main
  HttpOverrides.global= MyHttpOverrides();
  RepositorieImplement repositorieImplement = RepositorieImplement();
  await repositorieImplement.getIdEmpresa().then((idEmpresa){
    print('id_?????${idEmpresa}');
    if(idEmpresa != null){
      print('id_?????${idEmpresa}');
      runApp(MyApp(PageHome.routePage));
    }else{
      runApp(MyApp(PageOnboarding.routePage));
    }
  });

}


class MyApp extends StatelessWidget {
  String routeInit;
  MyApp(this.routeInit);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(),
      child: OKToast(
        child: MaterialApp(
          navigatorKey: Utils.globalContext,
          debugShowCheckedModeBanner: false,
          title: 'Sentinel IoT',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: ColorsPalette.colorPrimary,
            iconTheme: const IconThemeData(color: ColorsPalette.colorGrey),
            backgroundColor: ColorsPalette.colorWhite,
            buttonTheme: const ButtonThemeData(
                buttonColor: ColorsPalette.colorPrimary,
                textTheme: ButtonTextTheme.primary),
          ),
          initialRoute: routeInit,
          routes: routes(),
        ),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpCliente(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
