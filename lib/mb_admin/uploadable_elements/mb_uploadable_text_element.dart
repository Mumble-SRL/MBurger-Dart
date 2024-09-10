import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing the text.
class MBUploadableTextElement extends MBUploadableElement {
  /// The text of the element.
  final String text;

  /// Initializes a text element with a locale identifier, a name and the ids of the text.
  MBUploadableTextElement(
    super.localeIdentifier,
    super.elementName, {
    required this.text,
  });

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    return [MBMultipartForm.name(parameterName, text)];
  }
}
