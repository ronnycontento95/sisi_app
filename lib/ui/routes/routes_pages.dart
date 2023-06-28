import 'package:flutter/cupertino.dart';

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
    ScreenDevice.routePage: (_) => ScreenDevice(),
    ScreenMenu.routePage: (_) => ScreenMenu(),
    ScreenWebView.routePage: (_) => ScreenWebView(),
    ScreenSpash.routePage:(_) => const ScreenSpash()
  };
}
