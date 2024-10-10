import 'package:flutter/material.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/ui/screen/screen_home.dart';
import 'package:sisi_iot_app/ui/screen/screen_onboarding.dart';
import 'package:sisi_iot_app/ui/useful/useful.dart';

import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';

class ScreenSpash extends StatefulWidget {
  const ScreenSpash({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenSpash;

  @override
  State<ScreenSpash> createState() => _ScreenSpashState();
}

class _ScreenSpashState extends State<ScreenSpash> {
  @override
  void initState() {
    super.initState();
    GlobalPreference().getIdEmpresa().then((idEmpresa) {
      Future.delayed(const Duration(milliseconds: 720), () async {
        String initialRoute =
            idEmpresa != null ? ScreenHome.routePage : ScreenOnBoarding.routePage;
        if (idEmpresa != null) {
          Useful.globalContext.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                  settings: RouteSettings(
                    name: initialRoute,
                  ),
                  builder: (_) => const ScreenHome()),
              (_) => false);
        } else {
          Useful.globalContext.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                  settings: RouteSettings(
                    name: initialRoute,
                  ),
                  builder: (_) => const ScreenOnBoarding()),
              (_) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: Colors.white,
        child: Scaffold(
          backgroundColor: UsefulColor.colorPrimary,
          body: SafeArea(
            child: Stack(
              children: [const BackgroundImagen(), copy()],
            ),
          ),
        ));
  }

  Widget copy() {
    return const Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          UsefulLabel.txtCopy,
          style: TextStyle(color: Colors.white),
        ));
  }
}

class BackgroundImagen extends StatelessWidget {
  const BackgroundImagen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        '${UsefulLabel.assetsImages}app.png',
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        fit: BoxFit.cover,
      ),
    );
  }
}
