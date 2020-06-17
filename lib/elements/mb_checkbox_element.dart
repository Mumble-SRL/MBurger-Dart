import 'mb_element.dart';

class MBCheckboxElement extends MBElement {
  bool value;

  MBCheckboxElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    value = dictionary['value'];
  }
}
