import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/screen/screen_home.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

import '../useful/useful.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';
import '../useful/useful_screen_route.dart';
import '../widgets/widget_button_view.dart';

class ScreenServiceDisconnected extends StatelessWidget {
  const ScreenServiceDisconnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              imagenDisconnected(),
              Text( UsefulLabel.lblTextdisconnectedWifi),
              WidgetButtonView(
                text: UsefulLabel.lblAgain,
                color: UsefulColor.colorPrimary,
                onTap: () {
                  Useful().checkConnection().then(
                    (value) {
                      if (value) {
                        Navigator.of(Useful.globalContext.currentContext!).pushAndRemoveUntil(
                            UsefulScreenRoute(builder: (context) => const ScreenHome()),
                            (Route<dynamic> route) => false);
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imagenDisconnected() {
    return const CircleAvatar(
      child: Icon(Icons.wifi_off_rounded),
    );
  }
}
