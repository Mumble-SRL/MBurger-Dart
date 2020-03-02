import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

class MBUploadableTextElement extends MBUploadableElement {
  final String text;

  MBUploadableTextElement(
      String localeIdentifier, String elementName, String text)
      : this.text = text,
        super(localeIdentifier, elementName);

  @override
  List<MBMultipartForm> toForm() {
    return [MBMultipartForm.name(parameterName, text)];
  }
}
