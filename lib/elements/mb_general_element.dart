import 'mb_element.dart';

/// This class represents a general MBurger element.
class MBGeneralElement extends MBElement {
  /// The value of the element.
  dynamic value;

  /// Initializes a general element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBGeneralElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    value = dictionary['value'];
  }
}
