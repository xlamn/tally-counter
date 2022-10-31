import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Localizations on BuildContext {
  AppLocalizations get local {
    return AppLocalizations.of(this)!;
  }
}
