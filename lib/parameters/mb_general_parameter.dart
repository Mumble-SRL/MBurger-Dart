import 'mb_parameter.dart';

/// A general parameter with a key and a value
class MBGeneralParameter extends MBParameter {
  /// The key of the parameter.
  final String key;

  /// The value of the parameter.

  final String value;

  /// Initializes a [MBGeneralParameter] with the key and the value.
  MBGeneralParameter({
    required this.key,
    required this.value,
  });

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    return {key: value};
  }
}
