import 'dart:ui';

import 'package:mburger/elements/mb_element.dart';

class MBColorElement extends MBElement {
  String colorString;

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

  MBColorElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    colorString = dictionary['value'] as String;
  }
}
