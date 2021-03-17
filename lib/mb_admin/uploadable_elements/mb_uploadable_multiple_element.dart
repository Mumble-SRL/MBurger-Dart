import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a multiple element.
class MBUploadableMultipleElement extends MBUploadableElement {
  /// The values selected.
  final List<String> values;

  MBUploadableMultipleElement(
    String localeIdentifier,
    String elementName,
    List<String> values,
  )   : this.values = values,
        super(localeIdentifier, elementName);

  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    for (int i = 0; i < values.length; i++) {
      String value = values[i];
      form.add(MBMultipartForm.name(_parameterNameForIndex(i), value));
    }
    return form;
  }

  String _parameterNameForIndex(int index) {
    return parameterName + '[' + index.toString() + ']';
  }
}
