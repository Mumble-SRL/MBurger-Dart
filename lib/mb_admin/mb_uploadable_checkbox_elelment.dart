import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

class MBUploadableCheckboxElement extends MBUploadableElement {
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
