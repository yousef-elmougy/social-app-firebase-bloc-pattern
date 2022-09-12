
import 'package:flutter/material.dart';
import 'package:social_app_firebase/core/extentions/translation_extension.dart';
import 'package:social_app_firebase/core/extentions/validation_extension.dart';

validInput(BuildContext context,String val, int min, int max, String type) {

  if (val.isNotNull) {

    // not valid username
    if (type == "username" && val.isValidName) return "${context.tr?.validateUserName}";

    // not valid email
    if (type == "email" && val.isValidEmail) return "${context.tr?.validateEmail}";

    // not valid phone
    if (type == "phone" && val.isValidPhone) return "${context.tr?.validatePhone}";

    // not valid password
    if (type == "password" && val.isValidPassword) return "${context.tr?.validatePassword}";

    // can't be Empty
    if (val.isEmpty) return "${context.tr?.requiredField}";

    // can't be less than $min
    if (val.length < min) return "${context.tr?.validateMin} $min";

    // can't be larger than $max
    if (val.length > max) return "${context.tr?.validateMax} $max";
  }
}
