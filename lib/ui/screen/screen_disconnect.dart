import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

import '../useful/useful.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';
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
                WidgetTextView(text: UsefulLabel.lblTextdisconnectedWifi),
                WidgetButtonView(text: 'Reintentar', color: UsefulColor.colorPrimary, onTap: (){
                  Useful().checkConnection().then((value) {
                    if (value) {
                      // Navigator.of(Useful.globalContext.currentContext!).pushAndRemoveUntil(CustomPageRoute(builder: (context) => const ScreenHome()), (Route<dynamic> route) => false);
                    }
                    // else {
                    //   GlobalFunction()
                    //       .speakMessage(UsefulLabel.textCheckConnectionWifi);
                    // }
                  });
                },)
              ],
            ),
          ),
        ));
  }
  Widget imagenDisconnected(){
    return const CircleAvatar(
      child: Icon(Icons.wifi_off_sharp),
    );
  }
}
