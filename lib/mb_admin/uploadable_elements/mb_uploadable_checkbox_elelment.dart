import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing a checkbox.
class MBUploadableCheckboxElement extends MBUploadableElement {
  /// The value of the checkbox.
  final bool value;

  /// Initializes a checkbox element with a locale, a name and it's value.
  MBUploadableCheckboxElement(
    super.localeIdentifier,
    super.elementName, {
    required this.value,
  });

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    if (value) {
      return [MBMultipartForm.name(parameterName, "on")];
    }
    return null;
  }
}
