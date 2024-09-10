import 'mb_element.dart';

/// This class represents a general MBurger element.
class MBGeneralElement extends MBElement {
  /// The value of the element.
  final dynamic value;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [value]: The value of the general element
  MBGeneralElement._({
    required super.dictionary,
    required this.value,
  });

  /// Initializes a general element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBGeneralElement({required Map<String, dynamic> dictionary}) {
    dynamic value = dictionary['value'];
    return MBGeneralElement._(
      dictionary: dictionary,
      value: value,
    );
  }
}
