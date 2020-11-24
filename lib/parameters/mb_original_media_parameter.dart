import 'package:mburger/mburger.dart';

/// A parameter to request original version of the images
class MBOriginalMediaParameter extends MBParameter {
  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    return {'original_media': 'true'};
  }
}
