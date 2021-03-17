import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

export 'package:http_parser/http_parser.dart' show MediaType;

/// An uploadable element representing some images.
class MBUploadableFilesElement extends MBUploadableElement {
  /// The array of paths of files.
  final List<String> files; // Files path

  MBUploadableFilesElement(
    String localeIdentifier,
    String elementName,
    List<String> files,
  )   : this.files = files,
        super(localeIdentifier, elementName);

  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    int index = 0;
    for (String file in files) {
      String? mime = lookupMimeType(file);
      form.add(
        MBMultipartForm.file(
          "$parameterName[$index]",
          file,
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
