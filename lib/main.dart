import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //Inicialice metodos en el main
  HttpOverrides.global = MyHttpOverrides();

  ///Save preferences id empresa
  // RepositorieImplement repositoryImplement = RepositorieImplement();
  await GlobalPreference().getIdEmpresa().then((idEmpresa) {
    if (idEmpresa != null) {
      if (kDebugMode) {
        print('GET SAVE >>> ID EMPRESA  $idEmpresa');
      }
      runApp(MyApp(ScreenHome.routePage));
    } else {
      runApp(MyApp(ScreenOnBoarding.routePage));
    }
  });
}

class MyApp extends StatelessWidget {
  String routeInit;

  MyApp(this.routeInit, {super.key});
  /// Verificar el estado de la connection
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _streamSubscription;

  @override
  Widget build(BuildContext context) {
    if (_streamSubscription == null) {
      Useful().initConnectivity(_connectivity);
      _streamSubscription = _connectivity.onConnectivityChanged.listen(Useful().updateConectivity);
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
            buttonTheme: const ButtonThemeData(buttonColor: UsefulColor.colorPrimary, textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(background: UsefulColor.colorWhite),
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
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
