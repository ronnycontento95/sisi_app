import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sisi_iot_app/ui/useful/useful_palette.dart';


class WidgetProgress extends StatefulWidget {
  const WidgetProgress({super.key});

  @override
  State<WidgetProgress> createState() => _WidgetProgressState();
}

class _WidgetProgressState extends State<WidgetProgress> {
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: UsefulColor.colorWhite,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: UsefulColor.colorWhite),
      child: Scaffold(
        backgroundColor: UsefulColor.colorWhite,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.stretchedDots(
                size: 50,
                color: UsefulColor.colorPrimary,
              ),
              const SizedBox(height: 10),
              Text("Espere porfavor")
              // const WidgetTextFieldPersonalized(
              //     type: 1,
              //     title: GlobalLabel.textWaitMoment,
              //     align: TextAlign.center,
              //     color: GlobalColors.colorLetterTitle,
              //     size: 16)
            ],
          ),
        ),
      ),
    );
  }
}
