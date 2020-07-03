import 'mb_element.dart';

class MBDropdownElement extends MBElement {
  List<MBDropdownElementOption> options;
  String selectedOption;

  MBDropdownElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    selectedOption = dictionary['value'] as String;
    List<Map<String, dynamic>> options =
        List<Map<String, dynamic>>.from(dictionary['options'] as List);
    if (options != null) {
      this.options =
          options.map((o) => MBDropdownElementOption(dictionary: o)).toList();
    }
  }
}

class MBDropdownElementOption {
  String key;
  String value;

  MBDropdownElementOption({Map<String, dynamic> dictionary}) {
    key = dictionary['key'] as String;
    value = dictionary['value'] as String;
  }
}
