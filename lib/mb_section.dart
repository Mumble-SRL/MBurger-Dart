import 'elements/mb_element.dart';

class MBSection {
  int id;
  int order;

  Map<String, MBElement> elements;

  DateTime availableAt;
  bool inEvidence;

  MBSection.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    order = dictionary['order'] as int;

    int timestamp = dictionary['available_at'] as int;
    availableAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    inEvidence = dictionary['in_evidence'] as bool;

    if (dictionary['elements'] is Map<String, dynamic>) {
      Map<String, dynamic> elements =
          dictionary['elements'] as Map<String, dynamic>;
      this.elements = {};
      if (elements != null) {
        for (String key in elements.keys) {
          this.elements[key] = MBElementsUtilities.elementFromDictionary(
              elements[key] as Map<String, dynamic>);
        }
      }
    } else {
      this.elements = {};
    }
  }
}
