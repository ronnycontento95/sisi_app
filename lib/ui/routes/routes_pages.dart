import 'package:flutter/cupertino.dart';
import 'package:sisi_iot_app/ui/pages/page_home.dart';
import 'package:sisi_iot_app/ui/pages/page_login.dart';
import 'package:sisi_iot_app/ui/pages/page_menu.dart';
import 'package:sisi_iot_app/ui/pages/page_nodos.dart';
import 'package:sisi_iot_app/ui/pages/page_onboarding.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    PageOnboarding.routePage: (_) => const PageOnboarding(),
    PageLogin.routePage: (_) => PageLogin(),
    PageHome.routePage: (_) => PageHome(),
    PageNodos.routePage: (_) => PageNodos(),
    PageMenu.routePage: (_) => PageMenu(),
  };
}
