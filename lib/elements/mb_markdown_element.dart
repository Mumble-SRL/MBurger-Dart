import 'mb_element.dart';

/// This class represents a MBurger markdown element.
class MBMarkdownElement extends MBElement {
  /// The value of the element.
  String value;

  /// Initializes a text element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBMarkdownElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    value = dictionary['value'] as String;
  }
}
