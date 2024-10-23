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
  int pageScreen = 0;
  List<Widget> itemScreen = [
    const ScreenChartNodos(),
    const ScreenCardNodos(),
    const ScreenGoogle(),
    const ScreenGoogle(),
    const ScreenProfile(),
  ];

  List<TabItem> items = [
    const TabItem(icon: Icons.home, title: 'Home'),
    const TabItem(icon: Icons.push_pin, title: 'Tarjetas'),
    const TabItem(icon: Icons.menu, title: 'Menu'),
    const TabItem(icon: Icons.public, title: 'Mapa'),
    const TabItem(icon: Icons.account_box, title: 'Perfil'),
  ];

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
            child: itemScreen[pageScreen], // Aquí seleccionamos la pantalla según el índice
          ),
        ],
      ),
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.black38,
        colorSelected: UsefulColor.colorPrimary,
        indexSelected: pageScreen,
        isFloating: true,
        onTap: (int index) => setState(() {
          print('prueba >>> ingreso $index');
          if (index == 2) {
            pvPrincipal.showBottomSheet(context);
          } else {
            pageScreen = index;
          }
        }),
      ),
    );
  }
}
