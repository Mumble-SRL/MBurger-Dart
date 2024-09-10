import 'mb_element.dart';

/// This class represents a MBurger checkbox element.
class MBCheckboxElement extends MBElement {
  /// If the checkbox element is checked or not.
  final bool value;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [value]: The value of the checkbox
  MBCheckboxElement._({
    required super.dictionary,
    required this.value,
  });

  /// Initializes a checkbox element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBCheckboxElement({required Map<String, dynamic> dictionary}) {
    bool value = false;
    if (dictionary['value'] is bool) {
      value = dictionary['value'] as bool;
    }
    return MBCheckboxElement._(
      dictionary: dictionary,
      value: value,
    );
  }
}
