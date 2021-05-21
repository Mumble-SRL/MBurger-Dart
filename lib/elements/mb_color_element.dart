import 'dart:ui';

import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger color element.
class MBColorElement extends MBElement {
  /// The value of the element.
  final String? colorString;

  /// Returns the [Color] object for this element.
  Color? get color => _hexToColor(colorString);

  Color? _hexToColor(String? hexString, {String alphaChannel = 'FF'}) {
    if (hexString == '' || hexString == null) {
      return null;
    }

    int? intValue =
        int.tryParse(hexString.replaceFirst('#', '0x$alphaChannel'));
    if (intValue != null) {
      return Color(intValue);
    } else {
      return null;
    }
  }

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [colorString]: The hex color string
  MBColorElement._({
    required Map<String, dynamic> dictionary,
    required this.colorString,
  }) : super(dictionary: dictionary);

  /// Initializes a color element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBColorElement({required Map<String, dynamic> dictionary}) {
    String? colorString;
    if (dictionary['value'] is String) {
      colorString = dictionary['value'] as String;
    }
    return MBColorElement._(
      dictionary: dictionary,
      colorString: colorString,
    );
  }
}
