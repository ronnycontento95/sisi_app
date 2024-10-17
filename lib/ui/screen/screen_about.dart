import 'package:flutter/material.dart';

import '../useful/useful_palette.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}
