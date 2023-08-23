import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';


class ScreenSpash extends StatelessWidget {
  const ScreenSpash({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenSpash;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: UsefulColor.colorWhite,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                backgroundImagen(),
                copy()
              ],
            ),
          ),
        ));
  }
  
  Widget backgroundImagen(){
    return const Image(
      fit: BoxFit.fill,
        height: double.infinity,
        image: AssetImage('${UsefulLabel.assetsImages}spash.jpg'));
  }

  Widget copy(){
      return Align(
          alignment: Alignment.bottomCenter,
          child: const Text(UsefulLabel.txtCopy));

  }
}
