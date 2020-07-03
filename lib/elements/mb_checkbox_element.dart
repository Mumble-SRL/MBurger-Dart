import 'mb_element.dart';

/// This class represents a MBurger checkbox element.
class MBCheckboxElement extends MBElement {
  /// If the checkbox element is checked or not.
  bool value;

  /// Initializes a checkbox element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBCheckboxElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    value = dictionary['value'] as bool;
  }
}
