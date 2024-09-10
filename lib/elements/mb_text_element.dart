import 'mb_element.dart';

/// This class represents a MBurger text element.
/// It is the counterpart of the 'text' and 'textarea' types on the dashboard
class MBTextElement extends MBElement {
  /// The value of the element.
  final String value;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [value]: The textual value of the element
  MBTextElement._({
    required super.dictionary,
    required this.value,
  });

  /// Initializes a text element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBTextElement({required Map<String, dynamic> dictionary}) {
    String value = '';
    if (dictionary['value'] is String) {
      value = dictionary['value'] as String;
    }
    return MBTextElement._(
      dictionary: dictionary,
      value: value,
    );
  }
}
