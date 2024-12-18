import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/common.dart';

import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import '../widgets/widget_button_view.dart';
import 'screen_login.dart';

class ScreenOnBoarding extends StatelessWidget {
  const ScreenOnBoarding({Key? key}) : super(key: key);
  static const routePage = CommonLabel.routeScreenOnBoarding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 390,
                  child: PageView(
                    controller: null,
                    children: <Widget>[
                      widgetSlider(
                          context, CommonLabel.lblTitleMoni, CommonLabel.lblSubMoni),
                    ],
                  ),
                ),
                // widgetIndicator(),
                const ButtonOnBoarding(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetSlider(BuildContext context, String text, String text_1) {
    return Column(
      children: [
        Expanded(child: widgetOnboard()),
        con_text_wid(text),
        contTextSubtitle(text_1),
      ],
    );
  }

  Widget contTextSubtitle(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text( text)],
      ),
    );
  }

  Widget widgetOnboard() {
    return const Padding(
        padding: EdgeInsets.all(15),
        child: Image(
          image: AssetImage("${CommonLabel.assetsImages}connect.png"),
        ));
  }

  Widget widgetIndicator() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: DotsIndicator(
        decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.grey.shade300,
          activeColor: CommonColor.colorPrimary,
        ),
        dotsCount: 3,
      ),
    );
  }

  Widget con_text_wid(String text) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "!",
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: CommonLabel.letterWalkwayBold,
                    color: CommonColor.colorPrimary),
                children: <TextSpan>[
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: CommonLabel.letterWalkwayBold,
                      color: CommonColor.colorPrimary,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: CommonLabel.letterWalkwayBold,
                        color: CommonColor.colorPrimary),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class ButtonOnBoarding extends StatelessWidget {
  const ButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          WidgetButtonView(
            text: CommonLabel.lblStartNow,
            color: CommonColor.colorPrimary,
            onTap: () {
              Navigator.of(Common.globalContext.currentContext!)
                  .pushNamed(ScreenLogin.routePage);
            },
          ),
        ],
      ),
    );
  }
}
