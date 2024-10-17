import 'package:flutter/cupertino.dart';
import 'package:sisi_iot_app/ui/screen/screen_Google.dart';
import 'package:sisi_iot_app/ui/screen/screen_card_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_chart_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_data_device.dart';
import 'package:sisi_iot_app/ui/screen/screen_terms.dart';

import '../screen/screen_home.dart';
import '../screen/screen_login.dart';
import '../screen/screen_menu.dart';
import '../screen/screen_device.dart';
import '../screen/screen_onboarding.dart';
import '../screen/screen_splash.dart';
import '../screen/screen_web_device.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    ScreenOnBoarding.routePage: (_) => const ScreenOnBoarding(),
    ScreenLogin.routePage: (_) => ScreenLogin(),
    ScreenHome.routePage: (_) => const ScreenHome(),
    ScreenDevice.routePage: (_) => const ScreenDevice(),
    ScreenMenu.routePage: (_) => ScreenMenu(),
    ScreenWebView.routePage: (_) => const ScreenWebView(),
    ScreenSpash.routePage:(_) => const ScreenSpash(),
    ScreenCardNodos.routePage:(_) => const ScreenCardNodos(),
    ScreenGoogle.routePage:(_) => const ScreenGoogle(),
    ScreenDataDeviceId.routePage:(_) => const ScreenDataDeviceId(),
    ScreenChartNodos.routePage:(_) => const ScreenChartNodos(),
    ScreenTermCondition.routePage:(_) => const ScreenTermCondition()

  };
}
