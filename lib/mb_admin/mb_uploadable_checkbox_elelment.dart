import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a checkbox.
class MBUploadableCheckboxElement extends MBUploadableElement {
  /// The value of the checkbox.
  final bool value;

  MBUploadableCheckboxElement(
      String localeIdentifier, String elementName, bool value)
      : this.value = value,
        super(localeIdentifier, elementName);

  @override
  List<MBMultipartForm> toForm() {
    if (value) {
      return [MBMultipartForm.name(parameterName, "on")];
    }
    return null;
  }
}
