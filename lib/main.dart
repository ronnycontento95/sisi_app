import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/config/network_status.dart';
import 'package:sisi_iot_app/ui/common/common.dart';
import 'package:sisi_iot_app/ui/provider/provider_setting.dart';
import 'package:sisi_iot_app/config/theme.dart';
import 'package:sisi_iot_app/ui/screen/screen_splash.dart';

import 'data/repositories/repository_implement.dart';
import 'ui/routes/routes_pages.dart';
import 'ui/routes/routes_provider.dart';
import 'ui/screen/screen_home.dart';
import 'ui/screen/screen_onboarding.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    if (androidDeviceInfo.version.sdkInt < 30) {
      HttpOverrides.global = MyHttpOverrides();
    }
  }
  NetworkStatus().init();
  await GlobalPreference().getIdEmpresa().then((idEmpresa) {
    if (idEmpresa != null) {
      runApp(MyApp(ScreenHome.routePage));
    } else {
      runApp(MyApp(ScreenOnBoarding.routePage));
    }
  });
}

class MyApp extends StatelessWidget {
  String routeInit;

  MyApp(this.routeInit, {super.key});

  @override
  Widget build(BuildContext context) {
    var localeMode = 'es';

    return MultiProvider(
      providers: providers(),
      child: OKToast(
        child: ChangeNotifierProvider(
          create: (_) => ProviderSetting(),
          builder: (context, _) => MaterialApp(
            title: 'Sentinel IoT',
            debugShowCheckedModeBanner: false,
            navigatorKey: Common.globalContext,
            initialRoute: ScreenSpash.routePage,
            routes: routes(),
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            themeMode: context.watch<ProviderSetting>().themeMode,
            locale: Locale(localeMode),
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
