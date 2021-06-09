import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger custom element,
/// with this you can populate an element using an external API.
class MBCustomElement extends MBElement {
  /// The value of this element, returned by the API configured from the MBurger dashboard.
  final dynamic value;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [collections]: The collections of this element
  MBCustomElement._({
    required Map<String, dynamic> dictionary,
    required this.value,
  }) : super(dictionary: dictionary);

  /// Initializes a custom element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBCustomElement({required Map<String, dynamic> dictionary}) {
    dynamic valueFromDictionary = dictionary['value'];

    return MBCustomElement._(
      dictionary: dictionary,
      value: valueFromDictionary,
    );
  }
}
