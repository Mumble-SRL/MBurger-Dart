import 'mb_element.dart';

class MBAddressElement extends MBElement {
  String address;
  double latitude;
  double longitude;

  MBAddressElement({Map<String, dynamic> dictionary}) : super(dictionary: dictionary) {
    Map<String, dynamic> addressDictionary = dictionary['value'];
    address = addressDictionary['address'];
    latitude = addressDictionary['latitude'];
    longitude = addressDictionary['longitude'];
  }
}