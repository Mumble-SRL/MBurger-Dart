import 'elements/mb_element.dart';

/// This class represents an MBurger section.
class MBSection {
  /// The id of the section.
  int id;

  /// The order of the section.
  int order;

  /// The elements of the section. The key of the dictionary is the name of the element, the value is an instance of a [MBElement] that represents the object.
  Map<String, MBElement> elements;

  /// The date the section is available.
  DateTime availableAt;

  /// Indicates if the section is in evidence.
  bool inEvidence;

  /// Initializes a section with the dictionary returned by the api.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs response
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
