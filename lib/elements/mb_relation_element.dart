import 'mb_element.dart';

class MBRelationElement extends MBElement {
  int blockId;
  int sectionId;

  MBRelationElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    if (dictionary['value'] != null) {
      if (dictionary['value'] is Map<String, dynamic>) {
        Map<String, dynamic> value = dictionary['value'];
        if (value['block_id'] != null && value['section_id'] != null) {
          blockId = int.tryParse(value['block_id']) ?? 0;
          sectionId = int.tryParse(value['section_id']) ?? 0;
        }
      }
    }
  }
}
