import 'mb_multipart_form.dart';

class MBUploadableElement {
  final String localeIdentifier;
  final String elementName;
  String get parameterName {
    return "elements[$localeIdentifier][$elementName]";
  }

  MBUploadableElement(this.localeIdentifier, this.elementName);

  List<MBMultipartForm> toForm(){
    return null;
  }

}