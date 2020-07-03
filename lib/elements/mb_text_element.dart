import 'mb_element.dart';

/// This class represents a MBurger text element.
/// It is the counterpart of the 'text' and 'textarea' types on the dashboard
class MBTextElement extends MBElement {
  /// The value of the element.
  String value;

  /// Initializes a text element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBTextElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    value = dictionary['value'] as String;
  }
}
