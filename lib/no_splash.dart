import 'package:flutter/cupertino.dart';

class NoSplashBehaviour extends ScrollBehavior {
  @override
  Widget buildViewPortChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}