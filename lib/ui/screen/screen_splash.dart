import 'package:flutter/material.dart';
import 'package:sisi_iot_app/data/repositories/repository_implement.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/common/common.dart';
import 'package:sisi_iot_app/ui/screen/screen_home.dart';
import 'package:sisi_iot_app/ui/screen/screen_onboarding.dart';

import 'package:sisi_iot_app/ui/common/common_label.dart';

class ScreenSpash extends StatefulWidget {
  const ScreenSpash({Key? key}) : super(key: key);
  static const routePage = CommonLabel.routeScreenSpash;

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
          Common.globalContext.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                  settings: RouteSettings(
                    name: initialRoute,
                  ),
                  builder: (_) => const ScreenHome()),
              (_) => false);
        } else {
          Common.globalContext.currentState!.pushAndRemoveUntil(
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
    return const AnnotatedRegion(
      value: Colors.white,
      child: Scaffold(
        backgroundColor: CommonColor.colorPrimary,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  width: 150,
                  image: AssetImage("${CommonLabel.assetsImages}app.png", ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    CommonLabel.txtCopy,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
