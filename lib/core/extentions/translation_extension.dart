
import 'package:flutter/material.dart';
import 'package:social_app_firebase/core/extentions/translation_extension.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension TranslateX on BuildContext {
  AppLocalizations? get tr => AppLocalizations.of(this);
}
