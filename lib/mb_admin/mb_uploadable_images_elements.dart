import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';
import 'package:http_parser/http_parser.dart';

class MBUploadableImagesElement extends MBUploadableElement {
  final List<String> images; // Images path in png
  MediaType mimeType;

  MBUploadableImagesElement(
    String localeIdentifier,
    String elementName,
    List<String> images,
    MediaType mimeType,
  )   : this.images = images,
        this.mimeType = mimeType,
        super(localeIdentifier, elementName);

  List<MBMultipartForm> toForm() {
    List<MBMultipartForm> form = [];
    int index = 0;
    for (String image in images) {
      form.add(MBMultipartForm.file("$parameterName[$index]", image, mimeType));
      index++;
    }
    return form;
  }
}
