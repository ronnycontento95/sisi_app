import 'package:flutter/material.dart';

class UsefulScreenRoute<T> extends MaterialPageRoute<T> {
  UsefulScreenRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInCubic),
      alwaysIncludeSemantics: true,
      child: child,
    );
  }
}








