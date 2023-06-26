import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_view.dart';

import '../global/global_label.dart';
import '../global/global_palette.dart';
import '../global/utils.dart';
import '../widgets/widget_button_view.dart';

class ScreenServiceDisconnected extends StatelessWidget {
  const ScreenServiceDisconnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: ColorsPalette.colorWhite,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                imagenDisconnected(),
                WidgetTextView(text: GlobalLabel.lblTextdisconnectedWifi),
                WidgetButtonView(text: 'Reintentar', color: ColorsPalette.colorPrimary, onTap: (){
                  Utils().checkConnection().then((value) {
                    if (value) {
                      // Navigator.of(Utils.globalContext.currentContext!).pushAndRemoveUntil(CustomPageRoute(builder: (context) => const ScreenHome()), (Route<dynamic> route) => false);
                    }
                    // else {
                    //   GlobalFunction()
                    //       .speakMessage(GlobalLabel.textCheckConnectionWifi);
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
