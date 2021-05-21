import 'mb_multipart_form.dart';

class MBUploadableElement {
  /// The locale of the element. This is needed to construct the parameter name.
  final String localeIdentifier;

  /// The name/key of the element.
  final String elementName;

  /// The name of the element, used when the element will be passed to the api.
  String get parameterName {
    return "elements[$localeIdentifier][$elementName]";
  }

  /// Initializes an uploadable element with a locale identifier and a name
  MBUploadableElement(
    this.localeIdentifier,
    this.elementName,
  );

  /// Converts the element to an array of MBMultipartForm representing it.
  List<MBMultipartForm>? toForm() {
    return null;
  }
}
