import 'package:flutter/material.dart';

import '../useful/useful_palette.dart';


class ScreenTermCondition extends StatelessWidget {
  const ScreenTermCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                ///TODO WIDGETS

              ],
            ),
          ),
        ),
        value: UsefulColor.colorWhite);
  }
}
