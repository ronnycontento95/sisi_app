import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'data/repositories/repository_implement.dart';
import 'ui/routes/routes_pages.dart';
import 'ui/routes/routes_provider.dart';
import 'ui/screen/screen_home.dart';
import 'ui/screen/screen_onboarding.dart';
import 'ui/useful/useful.dart';
import 'ui/useful/useful_palette.dart';


Future main() async {
  ///Lock device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();//Inicialice metodos en el main
  HttpOverrides.global= MyHttpOverrides();

  ///Save preferences id empresa
  RepositorieImplement repositoryImplement = RepositorieImplement();
  await repositoryImplement.getIdEmpresa().then((idEmpresa){
    if(idEmpresa != null){
      runApp(MyApp(ScreenHome.routePage));
    }else{
      runApp(MyApp(ScreenOnBoarding.routePage));
    }
  });

}
class MyApp extends StatelessWidget {
  String routeInit;
  MyApp(this.routeInit);
  /// Verificar el estado de la connection
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivityStreamSubscription;
  @override
  Widget build(BuildContext context) {
    if(_connectivityStreamSubscription == null){

    }
    return MultiProvider(
      providers: providers(),
      child: OKToast(
        child: MaterialApp(
          navigatorKey: Useful.globalContext,
          debugShowCheckedModeBanner: false,
          title: 'Sentinel IoT',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: UsefulColor.colorPrimary,
            iconTheme: const IconThemeData(color: UsefulColor.colorGrey),
            backgroundColor: UsefulColor.colorWhite,
            buttonTheme: const ButtonThemeData(
                buttonColor: UsefulColor.colorPrimary,
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
  HttpClient repositoryImplement(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
