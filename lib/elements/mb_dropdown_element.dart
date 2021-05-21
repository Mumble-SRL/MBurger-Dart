import 'mb_element.dart';

/// This class represents a MBurger dropdown element.
class MBDropdownElement extends MBElement {
  /// The possible options of the dropdown.
  final List<MBDropdownElementOption> options;

  /// The selected option of the dropdown.
  final String? selectedOption;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [options]: The options of the dropdown
  ///   - [selectedOption]: The selected option
  MBDropdownElement._({
    required Map<String, dynamic> dictionary,
    required this.options,
    required this.selectedOption,
  }) : super(dictionary: dictionary);

  /// Initializes a dropdown element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBDropdownElement({required Map<String, dynamic> dictionary}) {
    String? selectedOption;
    List<MBDropdownElementOption> options = [];

    if (dictionary['value'] is String) {
      selectedOption = dictionary['value'] as String;
    }

    if (dictionary['options'] is List) {
      List<Map<String, dynamic>> optionsMaps =
          List<Map<String, dynamic>>.from(dictionary['options'] as List);
      options = optionsMaps
          .map((o) => MBDropdownElementOption.fromDictionary(dictionary: o))
          .toList();
    }

    return MBDropdownElement._(
      dictionary: dictionary,
      options: options,
      selectedOption: selectedOption,
    );
  }
}

/// An option for dropdown elements
class MBDropdownElementOption {
  /// The key of the option.
  final String key;

  /// The value of the option.
  final String value;

  MBDropdownElementOption._({
    required this.key,
    required this.value,
  });

  /// Initializes the option with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBDropdownElementOption.fromDictionary(
      {required Map<String, dynamic> dictionary}) {
    String key = dictionary['key'] as String;
    String value = dictionary['value'] as String;
    return MBDropdownElementOption._(
      key: key,
      value: value,
    );
  }
}
