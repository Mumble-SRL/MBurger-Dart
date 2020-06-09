import 'mb_element.dart';

class MBRelationElement extends MBElement {
  List<MBRelation> relations;

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

  MBRelation firstRelation() {
    if (relations != null) {
      if (relations.length != 0) {
        return relations.first;
      }
    }
    return null;
  }
}

class MBRelation {
  int blockId;
  int sectionId;

  MBRelation({Map<String, dynamic> dictionary}) {
    if (dictionary['block_id'] != null && dictionary['section_id'] != null) {
      blockId = dictionary['block_id'];
      sectionId = dictionary['section_id'];
    }
  }
}
