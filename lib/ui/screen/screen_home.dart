import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/screen/screen_Google.dart';
import 'package:sisi_iot_app/ui/screen/screen_card_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_chart_nodos.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';

import '../provider/provider_principal.dart';
import '../useful/useful_label.dart';
import '../widgets/widget_tank.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeHome;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    final pvPrincipal = context.read<ProviderPrincipal>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pvPrincipal.getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));

    final pvPrincipal = context.watch<ProviderPrincipal>();

    return Scaffold(
        backgroundColor: UsefulColor.colorBackgroundWhite,
        body: Column(
          children: [
            // Usa Expanded para que la pantalla se ajuste correctamente
            Expanded(
              child: pvPrincipal.itemScreen[pvPrincipal
                  .pageScreen], // Aquí seleccionamos la pantalla según el índice
            ),
          ],
        ),
        bottomNavigationBar: pvPrincipal.buildBottomBar(context));
  }
}
