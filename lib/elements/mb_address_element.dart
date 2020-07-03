import 'mb_element.dart';

class MBAddressElement extends MBElement {
  String address;
  double latitude;
  double longitude;

  MBAddressElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    Map<String, dynamic> addressDictionary =
        dictionary['value'] as Map<String, dynamic>;
    address = addressDictionary['address'] as String;
    latitude = addressDictionary['latitude'] as double;
    longitude = addressDictionary['longitude'] as double;
  }
}
