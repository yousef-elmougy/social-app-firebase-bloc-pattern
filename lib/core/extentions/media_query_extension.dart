import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  bool isMobile() => MediaQuery.of(this).size.shortestSide < 600;

  double widthInPercent(double percent) =>
      MediaQuery.of(this).size.width * percent / 100;

  double heightInPercent(double percent) =>
      MediaQuery.of(this).size.height * percent / 100;
}
