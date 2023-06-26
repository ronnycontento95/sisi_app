import 'package:flutter/material.dart';

import '../global/global_palette.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [],
            ),
          ),
        ),
        value: ColorsPalette.colorWhite);
  }
}
