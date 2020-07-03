import 'dart:ui';

import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger color element.
class MBColorElement extends MBElement {
  /// The value of the element.
  String colorString;

  /// Returns the [Color] object for this element.
  Color get color => _hexToColor(colorString);

  Color _hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    if (colorString == null) {
      return null;
    }

    int intValue = int.tryParse(hexString.replaceFirst('#', '0x$alphaChannel'));
    if (intValue != null) {
      return Color(intValue);
    } else {
      return null;
    }
  }

  /// Initializes a color element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBColorElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    colorString = dictionary['value'] as String;
  }
}
