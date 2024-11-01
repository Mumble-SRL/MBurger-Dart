import 'mb_uploadable_element.dart';
import 'mb_multipart_form.dart';

/// An uploadable element representing a dropdown element.
class MBUploadableDropdownElement extends MBUploadableElement {
  /// The value selected.
  final String value;

  /// Initializes a dropdown element with a locale, a name and the selected value.
  MBUploadableDropdownElement(
    super.localeIdentifier,
    super.elementName, {
    required this.value,
  });

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    return [MBMultipartForm.name(parameterName, value)];
  }
}
