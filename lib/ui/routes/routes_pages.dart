import 'package:flutter/cupertino.dart';
import 'package:sisi_iot_app/ui/screen/screen_Google.dart';
import 'package:sisi_iot_app/ui/screen/screen_card_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_principal.dart';
import 'package:sisi_iot_app/ui/screen/screen_detail_nodo.dart';
import 'package:sisi_iot_app/ui/screen/screen_detail_diccionario.dart';
import 'package:sisi_iot_app/ui/screen/screen_terms.dart';

import '../screen/screen_home.dart';
import '../screen/screen_login.dart';
import '../screen/screen_onboarding.dart';
import '../screen/screen_splash.dart';
import '../screen/screen_web_device.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    ScreenOnBoarding.routePage: (_) => const ScreenOnBoarding(),
    ScreenLogin.routePage: (_) => ScreenLogin(),
    ScreenHome.routePage: (_) => const ScreenHome(),
    ScreenWebView.routePage: (_) => const ScreenWebView(),
    ScreenSpash.routePage:(_) => const ScreenSpash(),
    ScreenPrincipal.routePage:(_) => const ScreenPrincipal(),
    ScreenGoogle.routePage:(_) => const ScreenGoogle(),
    ScreenDetailNodo.routePage:(_) => const ScreenDetailNodo(),
    ScreenChartNodos.routePage:(_) => const ScreenChartNodos(),
    ScreenTermCondition.routePage:(_) => const ScreenTermCondition(),
    ScreenDetailDiccionario.routePage:(_) => const ScreenDetailDiccionario()


  };
}
