import 'mb_uploadable_element.dart';
import 'mb_multipart_form.dart';

/// An uploadable element representing a dropdown element.
class MBUploadableDropdownElement extends MBUploadableElement {
  /// The value selected.
  final String value;

  MBUploadableDropdownElement(
    String localeIdentifier,
    String elementName,
    String value,
  )   : this.value = value,
        super(localeIdentifier, elementName);

  @override
  List<MBMultipartForm> toForm() {
    return [MBMultipartForm.name(parameterName, value)];
  }
}
