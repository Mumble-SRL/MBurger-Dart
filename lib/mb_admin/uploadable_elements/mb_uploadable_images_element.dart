import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

export 'package:http_parser/http_parser.dart' show MediaType;

/// An uploadable element representing some images.
class MBUploadableImagesElement extends MBUploadableElement {
  /// The array of images.
  final List<String> images; // Images path in png

  /// Initializes an images element with a locale identifier, a name and the paths of the images
  MBUploadableImagesElement(
    super.localeIdentifier,
    super.elementName, {
    required this.images,
  });

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    int index = 0;
    for (String image in images) {
      String? mime = lookupMimeType(image);
      form.add(
        MBMultipartForm.file(
          "$parameterName[$index]",
          image,
          mime != null
              ? MediaType.parse(mime)
              : MediaType('application', 'octet-stream'),
        ),
      );
      index++;
    }
    return form;
  }
}
