import 'mb_element.dart';

class MBGeneralElement extends MBElement {
  dynamic value;

  MBGeneralElement({Map<String, dynamic> dictionary}) : super(dictionary: dictionary) {
    value = dictionary['value'];
  }
}