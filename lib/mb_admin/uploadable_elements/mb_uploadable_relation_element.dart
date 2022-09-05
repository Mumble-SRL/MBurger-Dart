import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a relation between sections.
class MBUploadableRelationElement extends MBUploadableElement {
  /// The ids of the sections of the element.
  final List<int> sectionIds;

  /// Initializes a relation element with a locale identifier, a name and the ids of the sections selected.
  MBUploadableRelationElement(
    String localeIdentifier,
    String elementName, {
    required this.sectionIds,
  }) : super(localeIdentifier, elementName);

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    for (int i = 0; i < sectionIds.length; i++) {
      String value = sectionIds[i].toString();
      form.add(MBMultipartForm.name(_parameterNameForIndex(i), value));
    }
    return form;
  }

  /// Returns the name of the parameter at index, to use in the form
  String _parameterNameForIndex(int index) {
    return "$elementName[${index.toString()}]";
  }
}
