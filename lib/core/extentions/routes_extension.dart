import 'package:flutter/material.dart';

extension RouteExtensions on String {
  Future<dynamic> goTo(context, {Object? args}) =>
      Navigator.pushNamed(context, this, arguments: args);

  Future<dynamic> goToReplace(context, {Object? args}) =>
      Navigator.pushReplacementNamed(context, this, arguments: args);

  Future<dynamic> goToClearStack(context, {Object? args}) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        this,
        (Route<dynamic> route) => false,
        arguments: args,
      );
}
