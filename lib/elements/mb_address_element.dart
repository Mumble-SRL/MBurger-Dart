import 'mb_element.dart';

/// This class represents a MBurger address element.
class MBAddressElement extends MBElement {
  /// The value of the element.
  final String? address;

  /// The latitude of the coordinate of the address.
  final double? latitude;

  /// The longitude of the coordinate of the address.
  final double? longitude;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [address]: The address
  ///   - [latitude]: The latitude
  ///   - [longitude]: The longitude
  MBAddressElement._({
    required super.dictionary,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  /// Initializes an address element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBAddressElement({required Map<String, dynamic> dictionary}) {
    String? address;
    double? latitude;
    double? longitude;
    if (dictionary['value'] is Map<String, dynamic>) {
      Map<String, dynamic> addressDictionary =
          dictionary['value'] as Map<String, dynamic>;
      address = addressDictionary['address'] != null
          ? addressDictionary['address'] as String
          : null;
      latitude = addressDictionary['latitude'] != null
          ? addressDictionary['latitude'] as double
          : null;
      longitude = addressDictionary['longitude'] != null
          ? addressDictionary['longitude'] as double
          : null;
    }
    return MBAddressElement._(
      dictionary: dictionary,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
