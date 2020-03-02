import 'package:http_parser/http_parser.dart';

class MBMultipartForm {
  final bool isFile;
  final String name;
  final String value;
  final String path;
  final MediaType mimeType;

  MBMultipartForm.name(this.name, this.value)
      : this.isFile = false,
        this.path = null,
        this.mimeType = null;

  MBMultipartForm.file(this.name, this.path, this.mimeType)
      : this.isFile = true,
        this.value = null;
}
