import 'elements/mb_element.dart';

/// This class represents an MBurger section.
class MBSection {
  /// The id of the section.
  final int id;

  /// The order of the section.
  final int order;

  /// The elements of the section. The key of the dictionary is the name of the element, the value is an instance of a [MBElement] that represents the object.
  final Map<String, MBElement> elements;

  /// The date the section is available.
  final DateTime availableAt;

  /// Indicates if the section is in evidence.
  final bool inEvidence;

  /// Initializes a `MBSection` with all its data
  MBSection({
    required this.id,
    required this.order,
    required this.elements,
    required this.availableAt,
    required this.inEvidence,
  });

  /// Initializes a section with the dictionary returned by the api.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs response
  factory MBSection.fromDictionary(Map<String, dynamic> dictionary) {
    int id = dictionary['id'] as int;
    int order = dictionary['order'] as int;

    Map<String, MBElement> elements = {};

    int timestamp = dictionary['available_at'] as int;
    DateTime availableAt =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    bool inEvidence = false;
    if (dictionary['in_evidence'] is bool) {
      inEvidence = dictionary['in_evidence'] as bool;
    }

    if (dictionary['elements'] is Map<String, dynamic>) {
      Map<String, dynamic> elementsFromApi =
          dictionary['elements'] as Map<String, dynamic>;
      for (String key in elementsFromApi.keys) {
        elements[key] = MBElementsUtilities.elementFromDictionary(
          elementsFromApi[key] as Map<String, dynamic>,
        );
      }
    }

    return MBSection(
      id: id,
      order: order,
      elements: elements,
      availableAt: availableAt,
      inEvidence: inEvidence,
    );
  }
}
