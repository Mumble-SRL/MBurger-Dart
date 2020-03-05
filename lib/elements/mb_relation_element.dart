import 'mb_element.dart';

class MBRelationElement extends MBElement {
  int blockId;
  int sectionId;

  MBRelationElement({Map<String, dynamic> dictionary}) : super(dictionary: dictionary) {
    if (dictionary['block_id'] != null && dictionary['section_id'] != null) {
      blockId = int.tryParse(dictionary['block_id']) ?? 0;
      sectionId = int.tryParse(dictionary['section_id']) ?? 0;
    }
  }
}