import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a relation between sections.
class MBUploadableRelationElement extends MBUploadableElement {
  /// The ids of the sections of the element.
  final List<int> sectionIds;

  MBUploadableRelationElement(
    String localeIdentifier,
    String elementName,
    List<int> sectionIds,
  )   : this.sectionIds = sectionIds,
        super(localeIdentifier, elementName);

  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    for (int i = 0; i < sectionIds.length; i++) {
      String value = sectionIds[i].toString();
      form.add(MBMultipartForm.name(_parameterNameForIndex(i), value));
    }
    return form;
  }

  String _parameterNameForIndex(int index) {
    return "$elementName[${index.toString()}]";
  }
}
