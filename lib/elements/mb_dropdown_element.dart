import 'mb_element.dart';

class MBDropdownElement extends MBElement {
  List<MBDropdownElementOption> options;
  String selectedOption;

  MBDropdownElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    selectedOption = dictionary['value'];
    List<Map<String, dynamic>> options =
        List<Map<String, dynamic>>.from(dictionary['options']);
    if (options != null) {
      this.options = options.map((o) => MBDropdownElementOption(dictionary: o));
    }
  }
}

class MBDropdownElementOption extends MBElement {
  String key;
  String value;

  MBDropdownElementOption({Map<String, dynamic> dictionary}) {
    key = dictionary['key'];
    value = dictionary['value'];
  }
}