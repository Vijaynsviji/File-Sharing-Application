import 'package:flutter/material.dart';
import 'generated/app_localizations.dart';

extension AppLocalizationsBuildContext on BuildContext {
  /// Allows shortcut access to strings via [context.strings.yourKey]
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
