import 'package:mburger/mburger.dart';

/// A parameter to force the locale fallback, if an element is empty the fallback will be returned instead
class MBForceLocaleFallbackParameter extends MBParameter {
  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    return {'force_locale_fallback': 'true'};
  }
}
