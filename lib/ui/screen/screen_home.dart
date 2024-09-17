import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sisi_iot_app/ui/screen/screen_Google.dart';
import 'package:sisi_iot_app/ui/screen/screen_card_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_chart_nodos.dart';
import 'package:sisi_iot_app/ui/screen/screen_terms.dart';
import 'package:sisi_iot_app/ui/useful/useful_label.dart';
import 'package:sisi_iot_app/ui/widgets/widget_appbar.dart';
import 'package:sisi_iot_app/ui/widgets/widget_custom_bottom_sheet.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';
import 'package:sisi_iot_app/ui/widgets/widget_tank.dart';

///Useful
import '../useful/useful.dart';
import '../useful/useful_palette.dart';

///Pages
import 'screen_device.dart';

/// Provider
import '../provider/provider_principal.dart';

// class ScreenHome extends StatefulWidget {
//   const ScreenHome({Key? key}) : super(key: key);
//   static const routePage = UsefulLabel.routeHome;
//
//   @override
//   State<ScreenHome> createState() => _ScreenHomeState();
// }
//
// class _ScreenHomeState extends State<ScreenHome> {
//   // ProviderPrincipal? pvPrincipal;
//
//   @override
//   void initState() {
//     super.initState();
//     // pvPrincipal = Provider.of<ProviderPrincipal>(context, listen: false);
//     // SchedulerBinding.instance.addPostFrameCallback((_) {
//     //   pvPrincipal!.getUser(context);
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const BodyHome();
//   }
// }

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeHome;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int pageScreen = 0;
  List<Widget> itemScreen = [
    const ScreenHome(),
    const ScreenGoogle(),
    const ScreenCardNodos(),
    const ScreenCardNodos(),
    const ScreenCardNodos()
  ];

  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.push_pin,
      title: 'Tarjetas',
    ),
    const TabItem(
      icon: Icons.menu,
      title: 'menu',
    ),
    const TabItem(
      icon: Icons.public,
      title: 'Mapa',
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'profile',
    ),
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
    final pvPrincipal = context.read<ProviderPrincipal>();
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        appBar: WidgetAppBarHome(
            imagen: pvPrincipal.companyResponse.imagen ?? "",
            business: pvPrincipal.companyResponse.nombre_empresa,
            topic: pvPrincipal.companyResponse.topic ?? ""),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (pageScreen == 0) const ScreenChartNodos(),
              if (pageScreen == 1) const ScreenCardNodos(),
              if (pageScreen == 3)
                SizedBox(
                  height: MediaQuery.of(context).size.height, // Limita el tamaño
                  child: const ScreenGoogle(),
                ),
              if (pageScreen == 4) TankPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomBarCreative(
          items: items,
          backgroundColor: Colors.white,
          color: Colors.black38,
          colorSelected: UsefulColor.colorPrimary,
          indexSelected: pageScreen,
          isFloating: true,
          onTap: (int index) => setState(() {
            if (index == 2) {
              pvPrincipal.showBottomSheet(context);
            } else {
              pageScreen = index;
            }
          }),
        ),
      ),
    );
  }
}

class ScreenMenuNavbar extends StatelessWidget {
  const ScreenMenuNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: UsefulColor.colorPrimary,
                      size: 16,
                    )),
                const SizedBox(
                  width: 20,
                ),
                WidgetViewLabelText().labelTextTitle(
                    text: 'Que puedo hacer en Sentinel IoT', fontSize: 16),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(Useful.globalContext.currentContext!)
                        .pushNamed(ScreenTermCondition.routePage);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: UsefulColor.colorPrimary, width: 1.0)),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.policy,
                          color: UsefulColor.colorlettertitle,
                        ),
                        WidgetViewLabelText().labelTextNormal(
                            text: "Acerca de",
                            fontSize: 14,
                            colortext: UsefulColor.colorlettertitle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    prPrincipalRead.logoOut();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: UsefulColor.colorPrimary, width: 1.0)),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.login_rounded,
                          color: UsefulColor.colorlettertitle,
                        ),
                        WidgetViewLabelText().labelTextNormal(
                            text: "Cerrar sesión",
                            fontSize: 14,
                            colortext: UsefulColor.colorlettertitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetViewLabelText().labelTextNormal(
                    text: "Copyright ", fontSize: 12, colortext: UsefulColor.colorBlack),
                WidgetViewLabelText().labelTextNormal(
                    text: "2018. ", fontSize: 12, colortext: UsefulColor.colorBlack),
                WidgetViewLabelText().labelTextNormal(
                    text: "Sentinel, Sisi Internet of things",
                    fontSize: 16,
                    colortext: UsefulColor.colorPrimary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
