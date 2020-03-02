import 'mb_element.dart';

class MBTextElement extends MBElement {
  String value;

  MBTextElement({Map<String, dynamic> dictionary}) : super(dictionary: dictionary) {
    value = dictionary['value'];
  }
}