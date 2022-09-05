import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a multiple element.
class MBUploadableMultipleElement extends MBUploadableElement {
  /// The values selected.
  final List<String> values;

  /// Initializes a multiple element with a locale identifier, a name and the values selected.
  MBUploadableMultipleElement(
    String localeIdentifier,
    String elementName, {
    required this.values,
  }) : super(localeIdentifier, elementName);

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    for (int i = 0; i < values.length; i++) {
      String value = values[i];
      form.add(MBMultipartForm.name(_parameterNameForIndex(i), value));
    }
    return form;
  }

  /// Returns the name of the parameter at index, to use in the form
  String _parameterNameForIndex(int index) {
    return '$parameterName[$index]';
  }
}
