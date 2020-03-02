import 'elements/mb_element.dart';

class MBSection {
  int id;
  int order;

  Map<String, MBElement> elements;

  DateTime availableAt;
  bool inEvidence;

  MBSection.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'];
    order = dictionary['order'];

    int timestamp = dictionary['available_at'];
    availableAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    inEvidence = dictionary['in_evidence'];

    Map<String, dynamic> elements = dictionary['elements'];
    this.elements = {};
    if (elements != null) {
      for (String key in elements.keys) {
        this.elements[key] = MBElementsUtilities.elementFromDictionary(elements[key]);
      }
    }
  }
}