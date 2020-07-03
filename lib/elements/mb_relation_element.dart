import 'mb_element.dart';

/// This class represents a MBurger relation element.
class MBRelationElement extends MBElement {
  /// The relations of this element.
  List<MBRelation> relations;

  /// Initializes a relation element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBRelationElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    dynamic value = dictionary['value'];
    if (value != null) {
      if (value is Map<String, dynamic>) {
        relations = [MBRelation(dictionary: value)];
      } else if (value is List<dynamic>) {
        List<Map<String, dynamic>> relationsFromDict =
            List.castFrom<dynamic, Map<String, dynamic>>(value);
        relations =
            relationsFromDict.map((r) => MBRelation(dictionary: r)).toList();
      }
    }
  }

  /// The first relation for this element, if exists; [null] otherwise.
  MBRelation firstRelation() {
    if (relations != null) {
      if (relations.isNotEmpty) {
        return relations.first;
      }
    }
    return null;
  }
}

/// This object represent a relation.
class MBRelation {
  /// The block id for this relation.
  int blockId;

  /// The section id for this relation.
  int sectionId;

  /// Initializes a relation with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBRelation({Map<String, dynamic> dictionary}) {
    if (dictionary['block_id'] != null && dictionary['section_id'] != null) {
      blockId = dictionary['block_id'] as int;
      sectionId = dictionary['section_id'] as int;
    }
  }
}
