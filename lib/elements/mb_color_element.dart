import 'dart:ui';

import 'package:mburger/elements/mb_element.dart';

class MBColorElement extends MBElement {
  String colorString;

  Color get color => _hexToColor(colorString);

  Color _hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    if (colorString == null) {
      return Color.fromRGBO(0, 0, 0, 1);
    }

    int intValue = int.tryParse(hexString.replaceFirst('#', '0x$alphaChannel'));
    if (intValue != null) {
      return Color(intValue);
    } else {
      return Color.fromRGBO(0, 0, 0, 1);
    }
  }

  MBColorElement({Map<String, dynamic> dictionary}) : super(dictionary: dictionary) {
    colorString = dictionary['value'];
  }

}