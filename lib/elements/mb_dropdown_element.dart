import 'mb_element.dart';

/// This class represents a MBurger dropdown element.
class MBDropdownElement extends MBElement {
  /// The possible options of the dropdown.
  List<MBDropdownElementOption> options;

  /// The selected option of the dropdown.
  String selectedOption;

  /// Initializes a dropdown element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
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

/// An option for dropdown elements
class MBDropdownElementOption {
  /// The key of the option.
  String key;

  /// The value of the option.
  String value;

  /// Initializes the option with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBDropdownElementOption({Map<String, dynamic> dictionary}) {
    key = dictionary['key'] as String;
    value = dictionary['value'] as String;
  }
}
