import 'mb_element.dart';

/// This class represents a MBurger address element.
class MBAddressElement extends MBElement {
  /// The value of the element.
  String address;

  /// The latitude of the coordinate of the address.
  double latitude;

  /// The longitude of the coordinate of the address.
  double longitude;

  /// Initializes an address element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBAddressElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    Map<String, dynamic> addressDictionary =
        dictionary['value'] as Map<String, dynamic>;
    address = addressDictionary['address'] as String;
    latitude = addressDictionary['latitude'] as double;
    longitude = addressDictionary['longitude'] as double;
  }
}
