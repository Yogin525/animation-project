import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFadeSlideTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut
    );

  // final elastic = CurvedAnimation(parent: animation, curve: Curves.elasticOut);

return Align(
  alignment: Alignment.bottomLeft,
  child: SizeTransition(
    sizeFactor: curvedAnimation,
    axis: Axis.vertical,
    child: child,
  ),
);





  }
}
