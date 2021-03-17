import 'mb_element.dart';

/// This class represents a MBurger relation element.
class MBRelationElement extends MBElement {
  /// The relations of this element.
  final List<MBRelation> relations;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [relations]: The relations of this element
  MBRelationElement._({
    required Map<String, dynamic> dictionary,
    required this.relations,
  }) : super(dictionary: dictionary);

  /// Initializes a relation element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBRelationElement({required Map<String, dynamic> dictionary}) {
    List<MBRelation> relations = [];

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
    return MBRelationElement._(
      dictionary: dictionary,
      relations: relations,
    );
  }

  /// The first relation for this element, if exists; [null] otherwise.
  MBRelation? firstRelation() {
    if (relations.isNotEmpty) {
      return relations.first;
    }
    return null;
  }
}

/// This object represent a relation.
class MBRelation {
  /// The block id for this relation.
  final int? blockId;

  /// The section id for this relation.
  final int? sectionId;

  /// Initializes a relation with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBRelation({required Map<String, dynamic> dictionary})
      : blockId = dictionary['block_id'] != null
            ? dictionary['block_id'] as int
            : null,
        sectionId = dictionary['section_id'] != null
            ? dictionary['section_id'] as int
            : null;
}
